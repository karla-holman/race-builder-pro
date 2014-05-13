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
//= require_tree .

$(document).ready(function() {
    $(".date-picker").datepicker({
    	dateFormat: "yy-mm-dd"
  	});

  	$('#datetimepicker').datetimepicker({
        format: 'yyyy-mm-dd hh:mm:ss'
     });

  	$('[data-toggle="tooltip"]').tooltip({'placement': 'right'});

  	$("#horse_status_status_id").change(function(){
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
	    	(f).spin(false);
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