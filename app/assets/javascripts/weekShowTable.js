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
    var oTable = $('#weekShowTable').dataTable( {
       "sDom": "<'row'<'col-md-6'l><'col-md-6'f>r>t<'row'<'col-md-12'p i>>",
      "aoColumns": [{"sType": "natural"}, {"sType": "natural"}, {"sType": "natural"}, null],
       "aaSorting": [[0, "asc"]],
                "oLanguage": {
                  "sSearch": "Search Weeks:",
            "sLengthMenu": "Show  _MENU_  entries",
            "sInfo": "Showing <b>_START_ to _END_</b> of _TOTAL_ weeks"
        },
    });

    $('#weekShowTable_wrapper .dataTables_filter input').addClass("input-medium ");
    $('#weekShowTable-table_wrapper .dataTables_length select').addClass("span12"); 
});