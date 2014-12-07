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
    var oTable = $('.telTable').dataTable( {
       "sDom": "<'row'<'col-md-6'l><'col-md-6'f>r>t<'row'<'col-md-12'p i>>",
       "aoColumnDefs": [
          { "bSortable": false, "aTargets": [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ] }
        ],
       "aaSorting": [[ 6, "desc" ], [ 7, "desc" ]],
                "oLanguage": {
            "sLengthMenu": "Show  _MENU_  entries",
            "sInfo": "Showing <b>_START_ to _END_</b> of _TOTAL_ entries"
        },
    });

    $('.genericTable_wrapper .dataTables_filter input').addClass("input-medium ");
    $('.genericTable-table_wrapper .dataTables_length select').addClass("span12"); 
});