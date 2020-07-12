function paramReplace(name, string, value) {
    // Find the param with regex
    // Grab the first character in the returned string (should be ? or &)
    // Replace our href string with our new value, passing on the name and delimeter
    var re = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        delimeter = re.exec(string)[0].charAt(0),
        newString = string.replace(re, delimeter + name + "=" + value);

    return newString;
}

function InitSelection(id_pos, table, indexes) {
    var data = table.rows({selected: true}).data().toArray();
    var delete_button = $('.delete-action');
    var edit_button = $('.edit-action');
    if (delete_button.length > 0) {
        var href = delete_button.attr('href');
    }
    if (edit_button.length > 0) {
        var href_1 = edit_button.attr('href');
    }

    var ids = [];
    for (var i = 0; i < data.length; i++) {
        ids.push(data[i][id_pos]);
    }

    var current_row = table.rows(indexes).data().toArray();
    if (ids.length == 0) {
        console.log('111');
        if (delete_button.length > 0) {
            href = paramReplace("id", href, '0');
            delete_button.attr('href', href);
            // delete_button.attr('href', href.replace(/[&?]id=[^&]+/, '&id=0'));
        }
        if (edit_button.length > 0) {
            var arr = href_1.split('/');
            arr[2] = '00';
            href_1 = arr.join('/');
            edit_button.attr('href', href_1);
            // edit_button.attr('href', href_1.replace(/[0-9]/g, '0'));
        }
    }
    else {
        if (delete_button.length > 0) {
            href = paramReplace("id", href, ids);
            delete_button.attr('href', href);
            // delete_button.attr('href', href.replace(/id=[^&]+/, 'id=' + ids));
        }
        if (edit_button.length > 0) {
            var arr = href_1.split('/');
            arr[2] = current_row[0][id_pos];
            href_1 = arr.join('/');
            if (edit_button.length > 0) {
                edit_button.attr('href', href_1);
            }
        }
    }
}

function RunDatatable(list_identity, column_attr, id_pos) {
    column_attr = column_attr || null;
    var data_table_list = $('#' + list_identity);
    var table = data_table_list.DataTable({
        bDestroy: true,
        bProcessing: true,
        bServerSide: true,
        stateSave: true,
        sAjaxSource: data_table_list.data('source'),
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
            },
            select: {
                rows: " - %d ردیف انتخاب شده"
            }
        },
        "aoColumns": column_attr,
        "columnDefs": [

            {
                "targets": [id_pos],
                "visible": false,
                "searchable": false
            },
            {
                "width": "5%",
                "orderable": false,
                "className": 'select-checkbox',
                "targets": 0
            }
        ],
        select: {
            style:    'os',
            selector: 'td:first-child'
        },
        dom: 'l' + "Bfrtip",
        buttons: [
            {
                text: '<i class="fa fa-lg fa-check-circle"></i>',
                titleAttr: 'انتخاب همه',
                action: function () {
                    table.rows().select();
                }
            },
            {
                text: '<i class="fa fa-lg fa-circle"></i>',
                titleAttr: 'انتخاب هیچکدام',
                action: function () {
                    table.rows().deselect();
                }
            }
        ]
    });

    table.on('select', function (e, dt, type, indexes) {
        InitSelection(id_pos, table, indexes);
    });

    table.on('deselect', function (e, dt, type, indexes) {
        InitSelection(id_pos, table, indexes);
    });
}