class Sound
  def Sound.play(file)
    system "aplay sounds/#{file}.wav &"
  end
  
  def Sound.play_wait(file)
    system "aplay sounds/#{file}.wav"
  end
end