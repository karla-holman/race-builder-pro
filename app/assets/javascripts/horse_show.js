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
     
    $('#racestatus-table thead tr').each( function () {
        this.insertBefore( nCloneTh, this.childNodes[0] );
    } );
     
    $('#racestatus-table tbody tr').each( function () {
        this.insertBefore(  nCloneTd.cloneNode( true ), this.childNodes[0] );
    } );
     
    /*
     * Initialse DataTables, with no sorting on the 'details' column
     */
    var oTable = $('#racestatus-table').dataTable( {
       "sDom": "<'row'<'col-md-6'l><'col-md-6'f>r>t<'row'<'col-md-12'p i>>",
       "bSortClasses": false,
       "aaSorting": [[ 4, "desc" ], [ 3, "desc" ]],
                "oLanguage": {
            "sLengthMenu": "Show  _MENU_  entries",
            "sInfo": "Showing <b>_START_ to _END_</b> of _TOTAL_ entries"
        },
        "fnDrawCallback": function( oSettings ) {
         $(".edit_horserace").change(function(){
           form = $(this).closest("form");
           attemptUpdate(form);
           location.reload()
           return false;
         });
         $(".confirm_alert").change(function(){
          alert('You are already confirmed for another race. Unconfirm from other race to confirm for this one.')
          $(this).removeAttr('checked');
        });
       },
    });
    
    $('#racestatus-table_wrapper .dataTables_filter input').addClass("input-medium ");
    $('#racestatus-table_wrapper .dataTables_length select').addClass("span12"); 
    
    /* Add event listener for opening and closing details
     * Note that the indicator for showing which row is open is not controlled by DataTables,
     * rather it is done here
     */
    $('#racestatus-table tbody td i').live('click', function () {
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

function attemptUpdate(f){
    $.ajax({
      type: "POST",
      data: $(f).serialize(),
      url: $(f).attr("action")
    }).complete(function(data)
    {
      if(data.success)
      {
        (f).spin(false);
      }
      else
      {
        if(data.message)
        {
          alert(data.message);
        }
      }
    });
    return false;
  }
