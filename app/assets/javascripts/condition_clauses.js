$(document).ready(function(){
	var groupCount = 1;
	var clauseCount = 1;
	
  $(".addClause").click(function(){
  	var group = $(this).attr("group");
    $("#"+group).append($("#new_clause").html());
  });

  $(".addGroup").click(function(){
  	var div = $(this).attr("div");
    $('#'+div).append($("#new_group").html());
    groupCount++;
    $('#newGroup').attr("id", "group_"+groupCount);
    $('#newGroupInput').attr("group", "group_"+groupCount);
    $('#newGroupInput').click(function(){
  		var group = $(this).attr("group");
    	$("#"+group).append($("#new_clause").html());
  	});
    $('#newGroupInput').attr("id", "group_"+groupCount+"_input");
  });
});
