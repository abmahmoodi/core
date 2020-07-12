function ClientDatatable(list_identity, column_attr, sum_columns, id_pos, title, des_pos, sig_pos) {
    column_attr = column_attr || null;
    var data_table_list = $('#' + list_identity);
    var table = data_table_list.DataTable({
        bDestroy: true,
        bProcessing: true,
        stateSave: true,
        dom: 'Blfrtip',
        buttons: [
            {
                extend: 'print', text: '<i class="fa fa-print"></i> چاپ', footer: true,
                message: '<p style="font-family: samim">' + title + '</p>',
                customize: function (win) {
                    $(win.document.body).find('h1').text('');
                    $(win.document.body).find('table tbody td').eq(2).css('width', '150px');
                    $(win.document.body).find('table tbody td').eq(des_pos).css('width', '350px');
                    $(win.document.body).find('table tbody td').eq(sig_pos).css('width', '250px');
                    $(win.document.body).find('table tbody tr').each(function () {
                        console.log('11');
                        $(this).css('height', '80px');
                        $(this).find('td').eq(sig_pos).css('font-size', '8px');
                        $(this).find('td').eq(sig_pos).css('vertical-align', 'bottom');
                    });
                    $(win.document.body).find('table')
                        .addClass('compact')
                        .css('font-size', '10px');
                }

            },
            {extend: 'excelHtml5', text: 'خروجی اکسل', footer: true}
        ],

        oLanguage: {
            "sProcessing": "درحال پردازش...",
            "sLengthMenu": "نمایش محتویات _MENU_",
            "sZeroRecords": "موردی یافت نشد",
            "sInfo": "نمایش _START_ تا _END_ از مجموع _TOTAL_ مورد",
            "sInfoEmpty": "تهی",
            "sInfoFiltered": "",
            "sInfoPostFix": "",
            "sSearch": "جستجو:",
            "sUrl": "",
            "oPaginate": {
                "sFirst": "ابتدا",
                "sPrevious": "قبلی",
                "sNext": "بعدی",
                "sLast": "انتها"
            }
        },
        "aoColumns": column_attr,
        "columnDefs": [{
            "targets": [id_pos],
            "visible": false,
            "searchable": false
        }
        ],
        "bAutoWidth": false,

        "footerCallback": function (row, data, start, end, display) {
            if (!sum_columns) {
                return
            }
            var api = this.api(), data;

            // Remove the formatting to get integer data for summation
            var intVal = function (i) {
                return typeof i === 'string' ?
                i.replace(/[\$,]/g, '') * 1 :
                    typeof i === 'number' ?
                        i : 0;
            };
            //var sum_columns = [4,5,6,7,8,9];
            var price = [];
            var price_page = [];
            var nCells = row.getElementsByTagName('th');
            for (var i in sum_columns) {
                price[i] = api.column(sum_columns[i]).data().reduce(function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0);
                price_page[i] = api.column(sum_columns[i], {page: 'current'}).data().reduce(function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0);
                nCells[sum_columns[i]].innerHTML = price_page[i] + ' ( ' + price[i] + ' ) ';
            }
        },
        "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
            if ( aData[5] == "تحویل نشد" )
            {
                $('td', nRow).css('background-color', 'rgba(255, 179, 179, 0.95)');
            }
        }
    });

    $(document).ready(function () {
        $('#' + list_identity + ' tbody').on('click', 'tr', function () {
            var data_table = table.row(this).data();
            console.log(data_table[id_pos]);

            if ($(this).hasClass('selected')) {
                $(this).removeClass('selected');
                $('#cancel').attr('href', '/cancel_contract?id=0');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');

                var cancel_id = $('#cancel');
                var href = cancel_id.attr('href');
                cancel_id.attr('href', href.replace(/id=[^&]+/, 'id=' + data_table[id_pos]));
            }
        });

    });
}

