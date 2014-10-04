	$(document).ready(function() {
	/*
     * Initialse DataTables, with no sorting on the 'details' column
     */
    var oTable = $('#tel-table').dataTable( {
       "sDom": "<'row'<'col-md-6'l><'col-md-6'f>r>t<'row'<'col-md-12'p i>>",
       "bSortClasses": false,
       "bPaginate": false,
       "bFilter": false,
       "aaSorting": [[ 0, "desc" ], [ 3, "desc" ]],
        fnRowCallback  : function (nRow, aData) {
            switch(aData[0]){
            case 'Stakes':
              $('tr', nRow).eq(0).addClass("label-success")
              break;
            case 'Protocol':
               $('tr', nRow).eq(0).addClass("label-success")
              break;
            case 'Alternate':
               $('tr', nRow).eq(0).addClass("label-danger")
              break;
          }
        },
    })
 });