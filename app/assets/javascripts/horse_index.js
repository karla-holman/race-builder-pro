/* Table initialisation */
$(document).ready(function() {
    var responsiveHelper = undefined;
    var breakpointDefinition = {
        tablet: 1024,
        phone : 480
    };
    /*
     * Insert a 'details' column to the table
     */
    var nCloneTh = document.createElement( 'th' );
    var nCloneTd = document.createElement( 'td' );
    nCloneTd.innerHTML = '<i class="fa fa-plus-circle"></i>';
    nCloneTd.className = "center";
     
    $('#stable-table thead tr').each( function () {
        this.insertBefore( nCloneTh, this.childNodes[0] );
    } );
     
    $('#stable-table tbody tr').each( function () {
        this.insertBefore(  nCloneTd.cloneNode( true ), this.childNodes[0] );
    } );
     
    /*
     * Initialse DataTables, with no sorting on the 'details' column
     */
    var oTable = $('#stable-table').dataTable( {
       "sDom": "<'row'<'col-md-6'l><'col-md-6'f>r>t<'row'<'col-md-12'p i>>",
       "bSortClasses": false,
       "aaSorting": [],
                "oLanguage": {
            "sLengthMenu": "_MENU_ ",
            "sInfo": "Showing <b>_START_ to _END_</b> of _TOTAL_ entries"
        },
        fnRowCallback  : function (nRow, aData) {
            switch(aData[7]){
            case 'Race Ready':
              $('td', nRow).eq(7).css('color', 'green')
              break;
            case 'Not Race Ready':
              $('td', nRow).eq(7).css('color', 'red')
              break;
            case 'Inactive':
              $('td', nRow).eq(7).css('color', 'red')
              break;
            case 'Resting From Race':
              $('td', nRow).eq(7).css('color', 'yellow')
              break;
            case 'Steward\'s List':
              $('td', nRow).eq(7).css('color', 'blue')
              break;
            case 'Vet\'s List':
              $('td', nRow).eq(7).css('color', 'blue')
              break;
          }
        },
    });

    $("div.toolbar").html('<div class="table-tools-actions"><button class="btn btn-primary" style="margin-left:12px" id="test2">Add</button></div>');
    
    $('#stable-table_wrapper .dataTables_filter input').addClass("input-medium ");
    $('#stable-table_wrapper .dataTables_length select').addClass("span12"); 
    
    /* Add event listener for opening and closing details
     * Note that the indicator for showing which row is open is not controlled by DataTables,
     * rather it is done here
     */
    $('#stable-table tbody td i').live('click', function () {
        var nTr = $(this).parents('tr')[0];
        if ( oTable.fnIsOpen(nTr) )
        {
            /* This row is already open - close it */
            this.removeClass = "fa fa-plus-circle";
            this.addClass = "fa fa-minus-circle";     
            oTable.fnClose( nTr );
        }
        else
        {
            /* Open this row */
            this.removeClass = "fa fa-minus-circle";
            this.addClass = "fa fa-plus-circle";  
            oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr), 'details' );
        }
    });
    
        $(".select2-wrapper").select2({minimumResultsForSearch: -1});
});


/* Formating function for row details */
function fnFormatDetails ( oTable, nTr )
{
    var aData = oTable.fnGetData( nTr );
    var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;" class="inner-table">';
    sOut += '<tr><td>Hose Conditions:</td><td>'+aData[10]+'</td></tr>';
    sOut += '<tr><td>Trainer:</td><td>'+aData[8]+'</td></tr>';
    sOut += '<tr><td>Owner:</td><td>'+aData[9]+'</td></tr>';
    sOut += '</table>';
     
    return sOut;
}