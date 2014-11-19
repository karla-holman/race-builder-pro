$(document).ready(function() {
	
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
  $("#day-table").droppable({
    drop: function(event, ui) {
    	//getting the ID of the race, should be the first number
      var race_id = $(ui.draggable).text().match(/\d+/);
      race_id = race_id[0];
      var day_id = $("#day-id").data('day');
      $("#dialog-confirm").dialog({
        resizable: false,
        height:140,
        modal: true,
        buttons: {
          "OK": function() {
            $.ajax({url: "/days/add_race", type: "POST", data: {day: {race_id: race_id, day_id: day_id}}}).done(function(data){
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

  $('.remove_from_day').on('click', function (e) {
    var race_id = $(this).attr("race");
    $.ajax({url: "/days/remove_race", type: "POST", data: {day: {race_id: race_id}}}).done(function(data){
          location.reload(true);
    });
  })
})
