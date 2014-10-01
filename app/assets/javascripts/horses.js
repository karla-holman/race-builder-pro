$(document).ready(function() {
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
