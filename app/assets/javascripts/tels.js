$(document).ready(function() {
	
	//Below is all code for the drag and drop functionality
  var c = {};

  //Make rows of tables draggable, rows will drag on top of other table
  $("#drag-table tr").draggable({
    helper: "clone",
    zIndex: 100,
    start: function(event, ui) {
       $("#tel-table").css("background-color", "#B1FAC5");
      c.tr = this;
      c.helper = ui.helper;
    }
  });

  $(".page-container").droppable({
    drop: function(event, ui) {
       $("#tel-table").css("background-color", "");
    }
  });

  //Handling what happens when row is dropped in the next table
  $("#tel-table").droppable({
    drop: function(event, ui) {
    	//getting the ID of the race, should be the first number
      var race_id = $(ui.draggable).text().match(/\d+/);
      race_id = race_id[0];
      var tel_id = $("#tel-id").data('tel');
      $("#dialog-confirm").dialog({
        resizable: false,
        height:140,
        modal: true,
        buttons: {
          "OK": function() {
            $.ajax({url: "/tels/add_race", type: "POST", data: {tel: {race_id: race_id, tel_id: tel_id}}}).done(function(data){
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

  $(".add_race_to_tel").change(function(){
    var tel_id = $(this).val();
    var race_id = $(this).attr("race");
    $.ajax({url: "/tels/add_race", type: "POST", data: {tel: {race_id: race_id, tel_id: tel_id}}}).done(function(data){
              location.reload(true);
            });
  });

  $('.remove_from_day').on('click', function (e) {
    var race_id = $(this).attr("race");
    $.ajax({url: "/tels/remove_race", type: "POST", data: {tel: {race_id: race_id}}}).done(function(data){
          location.reload(true);
    });
  })
})
