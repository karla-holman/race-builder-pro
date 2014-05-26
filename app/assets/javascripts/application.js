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
        format: 'yyyy-MM-dd hh:mm:ss'
     });

  	$('[data-toggle="tooltip"]').tooltip({'placement': 'right'});

  	$('.generic-table').dataTable({sPaginationType: "full_numbers"});

    $('#racestatus-table').dataTable({
      sPaginationType: "full_numbers",
      "fnDrawCallback": function( oSettings ) {
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
      }
    });

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

    $('#tel-table').dataTable({
      "bPaginate": false,
      "bInfo" : false,
      "bFilter": false,
      "paging":  false,
      "aaSorting": [[ 0, "desc" ], [ 3, "desc" ]],
      "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [0,1,2,3,4] }],
      "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
        switch(aData[0]){
          case 'Protocol':
            $(nRow).eq(0).css('color', 'green')
            break;
          case 'Alternate':
            $(nRow).eq(0).css('color', 'red')
            break;
        }
      }
    });

    $('#drag-table').dataTable({
      "bPaginate": false,
      "bInfo" : false,
      "bFilter": false,
      "paging":  false,
      "aaSorting": [[ 4, "desc" ]],
      "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [0,1,2,3,4] }]
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

    var c = {};

    $("#drag-table tr").draggable({
      helper: "clone",
      zIndex: 100,
      start: function(event, ui) {
        c.tr = this;
        c.helper = ui.helper;
      }
    });

    $("#tel-table tr").droppable({
      drop: function(event, ui) {
        var id = $(ui.draggable).text().match(/\d/);
        id = id[0];
        var race_day = $("#race-day").data('day');
        $("#dialog-confirm").dialog({
          resizable: false,
          height:140,
          modal: true,
          buttons: {
            "Protocol": function() {
              $.ajax({url: "/tels", type: "POST", data: {tel: { section: "Protocol", race_id: id, day: race_day}}});
              $(this).dialog("close");
              $(c.tr).remove();
              $(c.helper).remove();
              location.reload(true);
            },
            "Alternate": function() {
              $.ajax({url: "/tels", type: "POST", data: {tel: { section: "Alternate", race_id: id, day: race_day}}});
              $(this).dialog("close");
              $(c.tr).remove();
              $(c.helper).remove();
              location.reload(true);
            },
            Cancel: function() {
              $(this).dialog("close");
            }
          }
        });
        
      }
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