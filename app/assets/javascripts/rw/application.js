// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//=	require	jquery
//= require jquery.turbolinks
//= require rw/jquery-ui
//=	require	jquery_ujs
//=	require	rw/bootstrap.min
//=	require	rw/js.cookie.min.js
//= require rw/jquery.slimscroll.min
//= require rw/jquery.blockui.min
//= require rw/bootstrap-switch.min
//= require rw/sweetalert.min
//= require rw/ui-sweetalert.min
//= require rw/jquery.backstretch.min
//= require rw/app.min
//= require rw/login-4
//= require rw/toastr
//= require rw/ui-toastr


//= require rw/layout
//= require rw/quick-sidebar.min
//= require rw/quick-nav.min

//= require rw/datatables.min
//= require rw/datatables.bootstrap
//= require rw/dataTables.buttons.min
//= require rw/jszip.min.js
//= require rw/buttons.print.min
//= require rw/buttons.html5.min

//= require rw/bootstrap-multiselect

//= require rw/jquery.Bootstrap-PersianDateTimePicker
//= require rw/calendar
//= require rw/jalali

//= require rw/jquery-clockpicker
//= require rw/jquery.plugin
//= require rw/jquery.realperson
//= require rw/persian-date.min
//= require rw/persian-datepicker.min


//= require turbolinks

//= require rw/select2.full.min
//= require rw/i18n/fa.js
//	require	rw/require
//= require rw/echarts
//=	require_tree .

function persian_number() {
    // persian={0:'۰',1:'۱',2:'۲',3:'۳',4:'۴',5:'۵',6:'۶',7:'۷',8:'۸',9:'۹'};
    // function traverse(el){
    //     if(el.nodeType==3){
    //         var list=el.data.match(/[0-9]/g);
    //         if(list!=null && list.length!=0){
    //             for(var i=0;i<list.length;i++)
    //                 el.data=el.data.replace(list[i],persian[list[i]]);
    //         }
    //     }
    //     for(var i=0;i<el.childNodes.length;i++){
    //         traverse(el.childNodes[i]);
    //     }
    // }
    // traverse(document.body);
}

function delete_alert() {
    $.rails.allowAction = function(link) {
        if (!link.attr('data-confirm')) {
            return true;
        }
        $.rails.showConfirmDialog(link);
        return false;
    };

    $.rails.confirmed = function(link) {
        link.removeAttr('data-confirm');
        return link.trigger('click.rails');
    };

// $.rails.showConfirmDialog = function(link) {
//     var html, message;
//     message = link.attr('data-confirm');
//     html = "<div class=\"modal\" id=\"confirmationDialog\">\n  <div class=\"modal-header\">\n    <a class=\"close\" data-dismiss=\"modal\">Ã</a>\n    <h3>Are you sure Mr. President?</h3>\n  </div>\n  <div class=\"modal-body\">\n    <p>" + message + "</p>\n  </div>\n  <div class=\"modal-footer\">\n    <a data-dismiss=\"modal\" class=\"btn\">Cancel</a>\n    <a data-dismiss=\"modal\" class=\"btn btn-primary confirm\">OK</a>\n  </div>\n</div>";
//     $(html).modal();
//     return $('#confirmationDialog .confirm').on('click', function() {
//         return $.rails.confirmed(link);
//     });
// };


    $.rails.showConfirmDialog = function(link) {
        var html, message;
        message = link.attr('data-confirm');
        swal({
            title: 'تایید حذف',
            text: message,
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#DD6B55',
            confirmButtonText: 'بله',
            cancelButtonText: 'خیر',
            closeOnConfirm: false,
            closeOnCancel: false
        }, (function(_this) {
            return function(confirmed) {
                if (confirmed) {
                    console.log(link);
                    swal.close();
                    return $.rails.confirmed(link);
                } else {
                    swal.close();
                }
            };
        })(this));
    };
}

var ready;
ready = function () {
    setTimeout(function () {
        persian_number();
        delete_alert();
    }, 500);



};
$(document).ready(ready);

$(document).on('turbolinks:load', function() {
    setTimeout(function () {
        persian_number();
        delete_alert();
    }, 500);
});

$(document).on("turbolinks:request-start", function () {
    delete_alert();
});

$(document).on("turbolinks:request-end", function () {
    delete_alert();
});

$(document).ready(function() {

    $(".table-drop .dropdown-toggle").click(function () {
        $(this).parents(".table-responsive").toggleClass("res-drop");
    });


});

class User {
    // persian;
    persianNumber() {
        // let persian={0:'۰',1:'۱',2:'۲',3:'۳',4:'۴',5:'۵',6:'۶',7:'۷',8:'۸',9:'۹'};
        // function traverse(el){
        //     if(el.nodeType==3){
        //         var list=el.data.match(/[0-9]/g);
        //         if(list!=null && list.length!=0){
        //             for(var i=0;i<list.length;i++)
        //                 el.data=el.data.replace(list[i],persian[list[i]]);
        //         }
        //     }
        //     for(var i=0;i<el.childNodes.length;i++){
        //         traverse(el.childNodes[i]);
        //     }
        // }
        // traverse(document.body);
    }
}

let user = new User();

// jQuery(function() {
//     return $("[data-behavior='delete']").on("click", function(e) {
//         e.preventDefault();
//         return swal({
//             title: 'Are you sure?',
//             text: 'You will not be able to recover this imaginary file!',
//             type: 'warning',
//             showCancelButton: true,
//             confirmButtonColor: '#DD6B55',
//             confirmButtonText: 'Yes, delete it!',
//             cancelButtonText: 'No, cancel plx!',
//             closeOnConfirm: false,
//             closeOnCancel: false
//         }, (function(_this) {
//             return function(confirmed) {
//                 if (confirmed) {
//                     console.log('qqq');
//
//                     $.rails.confirmed = function(link) {
//                         link.removeAttr('data-behavior');
//                         return link.trigger('click.rails');
//                     };
//                     $.rails.showConfirmDialog = function(link) {
//                         console.log('2222');
//                         return $.rails.confirmed(link);
//                     }
//                 } else {
//                     swal('Cancelled', 'Your imaginary file is safe :)', 'error');
//                 }
//             };
//         })(this));
//     });
// });