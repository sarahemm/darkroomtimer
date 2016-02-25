require 'net/http'
require 'xmlsimple'
require 'digest'

class CereVoice
  REST_API_URL = "https://cerevoice.com/rest/rest_1_1.php"
  
  def initialize(userid, password, cache_dir)
    @userid = userid
    @password = password
    @cache_dir = cache_dir
  end
  
  def render_speech(text, voice = "Hannah")
    text_hash = Digest::MD5.hexdigest text.downcase
    cache_file = "#{@cache_dir}/#{text_hash}.mp3"
    
    # if the file is already cached, return that rather than re-rendering
    return cache_file if File.exist?(cache_file)
    
    # ask cerevoice to render speech and get a URL for it
    cv_url = get_cv_speech(text, voice)
    
    # get the file into the cache
    uri = URI.parse(cv_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    File.open(cache_file, 'w') do |f|
      http.get(uri.path) do |str|
        f.write str
      end
    end
    cache_file
  end
  
  # use CereVoice Cloud to render text into speech and return a URL to the sound file
  def get_cv_speech(text, voice)
    puts "Rendering #{text.length} characters of text in voice #{voice}"
    
    # build the XML REST request
    request = {
      "accountID"   => [@userid],
      "password"    => [@password],
      "audioFormat" => ["mp3"],
      "voice"       => [voice],
      "text"        => [text]
    }
    request_xml = XmlSimple.xml_out(request, {"rootName" => "speakExtended"})
    
    # send the request as a POST to CereVoice
    uri = URI(REST_API_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http_response = http.post(uri.path, request_xml, {"Content-type" => "text/xml"})
    
    # parse out the resulting URL and return it
    response = XmlSimple.xml_in(http_response.body)
    if(response["resultCode"][0].to_i != 1) then
      puts "Failed to generate speech, error code was #{response["resultCode"][0]} (#{response["resultDescription"][0]})"
      return nil
    end
    response["fileUrl"][0]
  end
end
