  $(document).ready(function() {

    $('#normal_dt').DataTable({
      scrollY: "50vh",
      scrollCollapse: true,
      paging: false,
      autoWidth: true,
      responsive: true,
      retrieve: true,
      dom: 'Bfrtip',
      columnDefs: [ {
          targets: [ 0 ],
          orderData: [ 0, 1 ]
      }, {
          targets: [ 1 ],
          orderData: [ 1, 0 ]
      } ],
      stateSave: true,
      buttons: [
        {
        extend: 'print',
        }
      ]
    });

    $("#btnPrint").printPreview({
      obj2print:'#main'
    });

    $('#normal_dt2').DataTable({
      scrollY: "33vh",
      scrollCollapse: true,
      paging: false,
      autoWidth: true,
      responsive: true,
      retrieve: true,
      dom: 'Bfrtip',
      stateSave: true,
      buttons: [
        {
        extend: 'print',
        }
      ]
    });

    $("#btnPrint").printPreview({
      obj2print:'#main'
    });

  });
