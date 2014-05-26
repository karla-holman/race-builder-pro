$(document).ready(function() {
	//Creating table with specific colors depending on the horse status
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

	//When changing horse status, submit the form
	$(".attribute").change(function(){
		form = $(this).closest("form");
		attemptUpdate(form);
		return false;
	});

	//When a condition is checked, submit the form
	$(".condition-list").change(function(){
		form = $(this).closest("form");
		attemptUpdate(form);
		return false
	});

	//Datatable so functionality works on ever page of table
	//When horse confirms, or is interested submit the form
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

	//function to try and submit form, currently will reload page after a successful submit
	function attemptUpdate(f){
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
