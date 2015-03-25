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
       "bPaginate": false,
       "aoColumnDefs": [
          { "bSortable": false, "aTargets": [ 0, 1, 2, 3, 4, 5, 6, 7 ] }
        ],
      "aoColumns": [null, null, null, null, {"sType": "natural"}, {"sType": "natural"}, null, null],
       "aaSorting": [[5, "desc"],[ 4, "desc" ]],
                "oLanguage": {
                  "sSearch": "Search Races:",
            "sLengthMenu": "Show  _MENU_  entries",
            "sInfo": "Showing <b>_START_ to _END_</b> of _TOTAL_ entries"
        },
        "fnInitComplete": function(oSettings, json) {
          $('.targetTels').each(function() {
            var num_races = this.getAttribute("num-races");
            num_races++;
            var rows = this.getElementsByTagName('tr');

            rows[num_races].setAttribute("style", "border-top: 2px solid black;");
          });
        },
    });

    $('.genericTable_wrapper .dataTables_filter input').addClass("input-medium ");
    $('.genericTable-table_wrapper .dataTables_length select').addClass("span12"); 
});