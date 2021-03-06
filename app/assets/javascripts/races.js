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
	if($("#menu_trainer_id").val() ){
		$.ajax({
	     url : 'menu/horseList',
	     method: "GET",
	     data: {trainer_id: $("#menu_trainer_id").val(), horse_id: $("#specificHorse").attr("horse")},
	     success: function(response) {
	     }
		})
	}
	$("#menu_trainer_id").change(function(){
		$.ajax({
	     url : 'menu/horseList',
	     method: "GET",
	     data: {trainer_id: $(this).val()},
	     success: function(response) {
	     }
		})
	});
	$('.suggestion').on('click', function (e) {
          var horse_id = $(this).attr("horse");
          var race_id = $(this).attr("race");
          $.ajax({url: "/notifications", type: "POST", data: {notification: { send_id: race_id, recv_id: horse_id, action: "Suggest"}}}).done(function(data){
                location.reload(true);
          });
    });
	$(".stakes_horse_id").change(function(){
		var horse_id = $(this).val();
		var race_id = $(this).attr("race");
	  $.ajax({url: "/notifications", type: "POST", data: {notification: { send_id: race_id, recv_id: horse_id, action: "Nominate"}}}).done(function(data){
					location.reload(true);
		});
	});
	
	$('.winner').on('click', function (e) {
		var horse_id = $(this).attr("horse");
		var race_title = $(this).attr("race-title");
		var race_id = $(this).attr("race");
	  $.ajax({url: "/races/add_winner", type: "POST", data: {race_title: race_title, race_id: race_id, horse_id: horse_id}}).done(function(data){
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

	$('.resetHorseStatuses').on('click', function (e) {
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
			$(".nomination_option").hide();
			$(".nomination_close").hide();
			$("#race_stakes").attr('checked', false);
			$("#race_needs_nomination").attr('checked', false);
		}
	});

	$("#race_stakes").change(function(){
		if ($(this).is(":checked")){
			$(".nomination_option").show();
		}
		else{
			$(".nomination_option").hide();
			$("#race_needs_nomination").attr('checked', false);
			$(".nomination_close").hide();
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

	$("#race_needs_nomination").change(function(){
		if($(this).is(":checked")){
			$(".nomination_close").show();
		}
		else
		{
			$(".nomination_close").hide();
		}
	});

	$("#showClaiming").change(function(){
		if($(this).is(":checked")){
			$("#claiming_one").attr('disabled', false);
		}
		else
		{
			$("#claiming_one").attr('disabled', true);
			$("#claiming_one").attr('value', null);
		}
	});

	$("#showYards").change(function(){
		if($(this).is(":checked")){
			$("#yardsDiv").show();
		}
		else
		{
			$("#yardsDiv").hide();
			$("#yards").attr('value', null);
		}
	});

	$("#switch_to_draft").on('click', function (e) {
        $('#draft_modal').modal('show');
      });

	$(".switch_to_draft_modal").on('click', function (e) {
		var modal_id = $(this).attr("modal-id");
        $('#'+modal_id).modal('show');
      });

	$("#set_horses_to_race_ready").on('click', function (e) {
        $('#reset_horses_modal').modal('show');
      });

	$("#remove_confirmed_horses").on('click', function (e) {
        $('#remove_confirmed_horses_modal').modal('show');
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
