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
