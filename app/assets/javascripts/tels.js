$(document).ready(function() {
	
	//Table with all options disabled
	$('#drag-table').dataTable({
    "bPaginate": false,
    "bInfo" : false,
    "bFilter": false,
    "paging":  false,
    "aaSorting": [[ 4, "desc" ]],
    "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [0,1,2,3,4] }]
  });

	//Table with green highlighting for Protocol, Red for Alternate, other options all disabled
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
        case 'Stakes':
          $(nRow).eq(0).css('color', 'green')
          break;
        case 'Alternate':
          $(nRow).eq(0).css('color', 'red')
          break;
      }
    }
  });

  $('#tel-index-table').dataTable({
    "aaSorting": [[ 4, "desc" ]],
    "sPaginationType": "full_numbers"
  });

	//Below is all code for the drag and drop functionality
  var c = {};

  //Make rows of tables draggable, rows will drag on top of other table
  $("#drag-table tr").draggable({
    helper: "clone",
    zIndex: 100,
    start: function(event, ui) {
      c.tr = this;
      c.helper = ui.helper;
    }
  });

  //Handling what happens when row is dropped in the next table
  $("#tel-table tr").droppable({
    drop: function(event, ui) {
    	//getting the ID of the race, should be the first number
      var id = $(ui.draggable).text().match(/\d+/);
      id = id[0];
      //grab race day from hidden div
      var race_day = $("#race-day").data('day');
      $("#dialog-confirm").dialog({
        resizable: false,
        height:140,
        modal: true,
        buttons: {
          "OK": function() {
            $.ajax({url: "/tels", type: "POST", data: {tel: { section: "Alternate", race_id: id, day: race_day}}}).done(function(data){
              location.reload(true);
            });
            $(this).dialog("close");
            $(c.tr).remove();
            $(c.helper).remove();
          },
          Cancel: function() {
            $(this).dialog("close");
          }
        }
      }); 
    }
  });

})
