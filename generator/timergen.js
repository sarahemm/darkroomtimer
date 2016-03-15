function addTableRow(table) {
  var $tr = $(table).find('tr:last').clone();
  $tr.find('input').attr('id', function(){
    var parts = this.id.match(/(\D+)(\d+)$/);
    return parts[1] + ++parts[2];
  });
  $tr.find('select').attr('id', function(){
    var parts = this.id.match(/(\D+)(\d+)$/);
    return parts[1] + ++parts[2];
  });
  $(table).append($tr);
  return true;
};

function rowToProcessLine(row) {
  var processLine = "";
  processLine  = $(row).find("input[id^='fullname']").val() + ",";
  processLine += $(row).find("input[id^='shortname']").val() + ",";
  processLine += $(row).find("input[id^='seconds']").val() + ",";
  tweak = $(row).find("input[id^='tweak']").prop('checked');
  if(tweak) {
    processLine += "Y,";
  } else {
    processLine += "N,";
  }
  processLine += $(row).find("select[id^='backlight']").val();
 
  return processLine;
}

function createProcessData(table) {
  var processData = $('#processname').val() + "\n";
  
  $(table).find('tr').each(function() {
    if($(this).find("input").val())
      processData += rowToProcessLine(this) + "\n";
  })
  return processData;
}

function generateBarcode(table) {
  processData = createProcessData(table);
  $('#processdata').val(processData);
  console.log(processData);
  $('#barcode').attr('src', "http://api-bwipjs.rhcloud.com/?bcid=azteccode&scale=1&text=" + encodeURIComponent(processData));
}

function deleteTableRows(table) {
  while($(table).find('tr').length > 2) {
    $(table).find('tr:last').remove();
  }
}

function importProcessData(data) {
  deleteTableRows('#timertable');
  
  var lines = data.split("\n");
  $('#processname').val(lines[0]);
  for(var line_nbr = 2; line_nbr < lines.length; line_nbr++) {
    addTableRow('#timertable');
  }
  for(var line_nbr = 1; line_nbr < lines.length; line_nbr++) {
    var fields = lines[line_nbr].split(",");
    var row_id = line_nbr - 1;
    $('#fullname' + row_id).val(fields[0]);
    $('#shortname' + row_id).val(fields[1]);
    $('#seconds' + row_id).val(fields[2]);
    if(fields[3] == 'Y') {
      $('#tweak' + row_id).prop('checked', true); 
    } else {
      $('#tweak' + row_id).prop('checked', false);       
    }
    $('#backlight' + row_id + " option").each(function() {
      $(this).prop('selected', $(this).val() == fields[4]);
    });
  }
}