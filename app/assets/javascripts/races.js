$(document).ready(function() {
	if($("#menu_horse_id").val() ){
		$.ajax({
	     url : 'menu/raceList',
	     method: "GET",
	     data: "horse_id=" + $("#specificHorse").attr("horse"),
	     success: function(response) {
	     		$('#racemenu').html(resonse);
	     }
		})
	}

	$("#menu_horse_id").change(function(){
		$.ajax({
	     url : 'menu/raceList',
	     method: "GET",
	     data: "horse_id=" + $(this).val(),
	     success: function(response) {
	     		$('#racemenu').html(resonse);
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

})
