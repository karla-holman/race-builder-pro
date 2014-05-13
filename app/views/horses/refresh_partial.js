if (@races !== null){
	$("#race-list").html("<%= escape_javascript(render(:partial => 'races', :locals => {:races => @races, :horse => @horse})).html_safe %>")
}
else{
	$("#race-list").html("")
}