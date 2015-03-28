$(document).ready(function() {
	$(".confirm_horse_from_tel").change(function(){
		var horse_id = $(this).val();
		var race_id = $(this).attr("race");
        var modal_id = 'modal_'+race_id+'_'+horse_id
        var status = $('#'+modal_id).attr("status");
        if (status != 'Confirmed')
        {
        	$.ajax({url: "/horseraces/confirm_horse", type: "POST", data: {race_id: race_id, horse_id: horse_id}}).done(function(data){
	 			location.reload(true);
	 		});
        }
        else
        {
        	$('#'+modal_id).modal('show');
        	$(this).val(null);
        }
    });
    $(".confirm_modal_commit_home").on('click', function (e) {
        var horserace_id = $(this).attr("horserace-id");
        $.ajax({
          url : '/horseraces/'+horserace_id,
           type: "PATCH",
           data: {horserace: { status: "Confirmed"}}
        }).complete(function(data)
          {
          	location.reload(true);
          })
    });
});