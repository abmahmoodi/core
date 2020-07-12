function hideFlash() {
    var flashCallback;
    flashCallback = function() {
        return $(".alert").fadeOut();
    };
    $(".alert").bind('click', (function(_this) {
        return function(ev) {
            return $(".alert").fadeOut();
        };
    })(this));
    $('.delete-action').attr('data-confirm', 'آیا اطمینان دارید؟');
    return setTimeout(flashCallback, 7000);
}