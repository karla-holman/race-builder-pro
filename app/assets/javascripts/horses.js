$(document).ready(function() {
	//When changing horse status, submit the form
	$(".attribute").change(function(){
		form = $(this).closest("form");
		attemptUpdate(form);
		return false;
	});

	//When a condition is checked, submit the form
	$(".equipment-list").change(function(){
		form = $(this).closest("form");
		attemptUpdate(form);
		return false
	});

	$("select#horse_country_code").change(function(){
		select_wrapper = $('#horse_state_code_wrapper');

		$('select', select_wrapper).attr('disabled', true)

		country_code = $(this).val()

	    url = "/horses/subregion_options?parent_region=" + country_code
	    select_wrapper.load(url)
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
