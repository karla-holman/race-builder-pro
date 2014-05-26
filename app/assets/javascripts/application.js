// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require bootstrap
//= require bootstrap-datetimepicker
//= require dataTables/jquery.dataTables
//= require_tree .

$(document).ready(function() {
  //Date Picker Format
  $(".date-picker").datepicker({
  	dateFormat: "yy-mm-dd"
	});

  //Date Time Picker Format
	$('#datetimepicker').datetimepicker({
      format: 'yyyy-MM-dd hh:mm:ss'
   });

  //Tooltip options
	$('[data-toggle="tooltip"]').tooltip({'placement': 'right'});

  //Base Style for generic tables
	$('.generic-table').dataTable({sPaginationType: "full_numbers"});

})