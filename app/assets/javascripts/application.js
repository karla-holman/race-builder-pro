// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require bootstrap
//= require bootstrap-datetimepicker
//= require dataTables/jquery.dataTables
//= require_tree .

$(document).ready(function() {
    $(".date-picker").datepicker({
    	dateFormat: "yy-mm-dd"
  	});

  	$('#datetimepicker').datetimepicker({
        format: 'yyyy-mm-dd hh:mm:ss'
     });

  	$('[data-toggle="tooltip"]').tooltip({'placement': 'right'});

  	$('.generic-table').dataTable({sPaginationType: "full_numbers"});

    $('#stable-table').dataTable({
    sPaginationType: "full_numbers",
    "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
      switch(aData[11]){
        case 'Race Ready':
          $('td', nRow).eq(11).css('color', 'green')
          break;
        case 'Not Race Ready':
          $('td', nRow).eq(11).css('color', 'red')
          break;
        case 'Resting From Race':
          $('td', nRow).eq(11).css('color', 'yellow')
          break;
        case 'Steward\'s List':
          $('td', nRow).eq(11).css('color', 'blue')
          break;
        case 'Vet\'s List':
          $('td', nRow).eq(11).css('color', 'blue')
          break;
        }
      }
    });

  	$(".attribute").change(function(){
  		form = $(this).closest("form");
  		attemptUpdate(form);
  		return false;
  	});

  	$(".condition-list").change(function(){
  		form = $(this).closest("form");
  		attemptUpdate(form);
  		return false
  	});

  	$(".edit_horserace").change(function(){
  		if($('#confirm_racestatus').is(":checked")) {
	     	message = confirm("Once you confirm for a race there is no unconfirm, do you still want to confirm for this race?");
	      if(!message) {
          location.reload(true);
  				return false;
	      }
        else{
          form = $(this).closest("form");
          attemptUpdate(form);
          return false;
        } 
	    }
      form = $(this).closest("form");
      attemptUpdate(form);
      return false;
  	});

  	function attemptUpdate(f)
	{
	  $.ajax({
	    type: "POST",
	    data: $(f).serialize(),
	    url: $(f).attr("action")
	  }).complete(function(data)
	  {
	    if(data.success)
	    {
	    	//(f).spin(false);
        location.reload(true);
	    }
	    else
	    {
	      if(data.message)
	      {
	        alert(data.message);
	      }
	    }
	  });
	  return false;
	}

})