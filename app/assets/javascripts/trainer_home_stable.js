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
    var oTable = $('#trainer-home-stable').dataTable( {
       "sDom": "<'row'<'col-md-6'l><'col-md-6'f>r>t<'row'<'col-md-12'p i>>",
       "bSortClasses": false,
       "bFilter" : false,
       "aaSorting": [],
                "oLanguage": {
            "sLengthMenu": "Show  _MENU_  horses",
            "sInfo": "Showing <b>_START_ to _END_</b> of _TOTAL_ horses"
        },
    });
    
    $('#trainer-home-stable_wrapper .dataTables_filter input').addClass("input-medium ");
    $('#trainer-home-stable_wrapper .dataTables_length select').addClass("span12"); 
});