$(document).ready(function() {
	$("#condition_category_id").change(function(){
		var type = $(this)[0].options[$(this)[0].selectedIndex].text;

		if (type == 'Age' || type == 'Wins'){
			$(".typeRange").show();
			$(".typeValue").hide();
			if (type == 'Wins'){
				$("#needsDateDiv").show();

				if($("#condition_needsDate").is(":checked")){
					$("#optionalDate").show();
				}
				else{
					$("#optionalDate").hide();
				}
			}
			else{
				$("#needsDateDiv").hide();
				$("#optionalDate").hide();
			}
		}
		else if (type == 'Sex' || type == 'Restriction'){
			$(".typeValue").show();
			$(".typeRange").hide();
			$("#needsDateDiv").hide();
			$("#optionalDate").hide();

		}
	});
	$("#condition_needsDate").change(function(){
		if($(this).is(":checked")){
			$("#optionalDate").show();
		}
		else
		{
			$("#optionalDate").hide();
		}
	});
})


