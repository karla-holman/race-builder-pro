$(document).ready(function() {
	$('.addParentOperator').on('click', function (e) {
		var node_id = $(this).attr("node");
		$.ajax({url: "addParentOperator", type: "POST", data: {node_id: node_id}})
		.done(function(data){
			return false;
		});
	});
	$('.addChildOperator').on('click', function (e) {
		var node_id = $(this).attr("node");
		$.ajax({url: "addChildOperator", type: "POST", data: {node_id: node_id}})
		.done(function(data){
			return false;
		});
	});
	$('.addCondition').on('click', function (e) {
		var node_id = $(this).attr("node");
		$.ajax({url: "addCondition", type: "POST", data: {node_id: node_id}})
		.done(function(data){
			return false;
		});
	});
	$('.removeNode').on('click', function (e) {
		var node_id = $(this).attr("node");
		$.ajax({url: "removeNode", type: "POST", data: {node_id: node_id}})
		.done(function(data){
			return false;
		});
	});
	$(".childSelector").change(function(){
		var value = $(this).attr("value");
		var node_id = $(this).attr("node");
		var url = '/condition_nodes/'+ node_id
		$.ajax({url: url, type: "PATCH", data: {condition_node: {value: value}, update: true}})
		.done(function(data){
			return false;
		})
	});
})