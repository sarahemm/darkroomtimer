function createWifiData(table) {
  var wifiData = "EXT-WIFI," + $('#wifiop').val() + "," + $('#ssid').val() + "," + $('#password').val() + "\n";
  
  return wifiData;
}

function generateBarcode(table) {
  wifiData = createWifiData(table);
  $('#wifidata').val(wifiData);
  $('#barcode').attr('src', "http://bwipjs-api.metafloor.com/?bcid=azteccode&scale=3&text=" + encodeURIComponent(wifiData));
}
