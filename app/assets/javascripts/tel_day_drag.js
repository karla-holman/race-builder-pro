	$(document).ready(function() {
	/*
     * Initialse DataTables, with no sorting on the 'details' column
     */
    var oTable = $('#drag-table').dataTable( {
       "sDom": "<'row'<'col-md-6'l><'col-md-6'f>r>t<'row'<'col-md-12'p i>>",
       "bSortClasses": false,
       "bFilter": false,
       "aaSorting": [[ 4, "desc" ]],
    })
 });