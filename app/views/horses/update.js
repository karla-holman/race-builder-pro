$('#equipmentPartial').empty().append('<%= j render "equipment" %>')

$(document).ready(function() {
	//When a condition is checked, submit the form
	$(".equipment-list").change(function(){
		form = $(this).closest("form");
		attemptUpdate(form);
		return false
	});

	function attemptUpdate(f){
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