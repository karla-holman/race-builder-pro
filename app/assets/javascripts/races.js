$(document).ready(function() {
	if($("#menu_horse_id").val() ){
		$.ajax({
	     url : 'menu/raceList',
	     method: "GET",
	     data: {horse_id: $("#specificHorse").attr("horse"), loadSettings: true},
	     success: function(response) {
	     }
		})
	}
	$("#menu_horse_id").change(function(){
		$.ajax({
	     url : 'menu/raceList',
	     method: "GET",
	     data: {horse_id: $(this).val(), loadSettings: true},
	     success: function(response) {
	     }
		})
	});

	$(".stakes_horse_id").change(function(){
		var horse_id = $(this).val();
		var race_id = $(this).attr("race");
	  $.ajax({url: "/notifications", type: "POST", data: {notification: { send_id: race_id, recv_id: horse_id, action: "Nominate"}}}).done(function(data){
					location.reload(true);
		});
	});


	$('.suggestion').on('click', function (e) {
		var horse_id = $(this).attr("horse");
		var race_id = $(this).attr("race");
	  $.ajax({url: "/notifications", type: "POST", data: {notification: { send_id: race_id, recv_id: horse_id, action: "Suggest"}}}).done(function(data){
					location.reload(true);
		});
	})

	$('.winner').on('click', function (e) {
		var horse_id = $(this).attr("horse");
		var race_id = $(this).attr("race");
	  $.ajax({url: "/races/add_winner", type: "POST", data: {race_id: race_id, horse_id: horse_id}}).done(function(data){
					location.reload(true);
		});
	})

	$('.scratch').on('click', function (e) {
		var horse_id = $(this).attr("horse");
		var race_id = $(this).attr("race");
	  $.ajax({url: "/races/scratch_horse", type: "POST", data: { race_id: race_id, horse_id: horse_id}}).done(function(data){
					location.reload(true);
		});
	})


	$(".transferOwner").change(function(){
		var owner_id = $(this).val();
		var horse_id = $(this).attr("horse");
	  $.ajax({url: "/horses/transferowner", type: "POST", data: {horse: {owner_id: owner_id, horse_id: horse_id}}}).done(function(data){
			location.reload(true);
		});
	});

	$(".transferTrainer").change(function(){
		var trainer_id = $(this).val();
		var horse_id = $(this).attr("horse");
	  $.ajax({url: "/horses/transfertrainer", type: "POST", data: {horse: {trainer_id: trainer_id, horse_id: horse_id}}}).done(function(data){
			location.reload(true);
		});
	});

	$("#race_category").change(function(){
		if ($(this).is(":checked")){
			$(".priority_option").show();
		}
		else{
			$(".priority_option").hide();
		}
	});

	$("#race_stakes").change(function(){
		if ($(this).is(":checked")){
			$(".nomination_option").show();
		}
		else{
			$(".nomination_option").hide();
		}
	});

	$("#race_race_type").change(function(){
		if (($(this).val() == 'Claiming') || ($(this).val() == 'Allowance Optional Claiming')
		|| ($(this).val() == 'Maiden Claiming') || ($(this).val() == 'Maiden Optional Claiming')){
			$("#claiming_prices").show();
		}
		else{
			$("#claiming_prices").hide();
		}
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
