/* Table initialisation */
$(document).ready(function() {
    var responsiveHelper = undefined;
    var breakpointDefinition = {
        tablet: 1024,
        phone : 480
    };
     
    /*
     * Initialse DataTables, with no sorting on the 'details' column
     */
    var oTable = $('#meet_index-table').dataTable( {
       "sDom": "<'row'<'col-md-6'l><'col-md-6'f>r>t<'row'<'col-md-12'p i>>",
       "bSortClasses": false,
       "aaSorting": [],
                "oLanguage": {
            "sLengthMenu": "_MENU_ ",
            "sInfo": "Showing <b>_START_ to _END_</b> of _TOTAL_ entries"
        },
    });
    
    $('#meet_index-table_wrapper .dataTables_filter input').addClass("input-medium ");
    $('#meet_index-table_wrapper .dataTables_length select').addClass("span12"); 
});