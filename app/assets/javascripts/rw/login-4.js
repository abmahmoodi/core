var Login = function () {
    return {
        //main function to initiate the module
        init: function () {
            // init background slide images
		    $.backstretch([
		        "/assets/rw/1.jpg",
                "/assets/rw/3.jpg",
                "/assets/rw/4.jpg"
		        ], {
		          fade: 1000,
		          duration: 8000
		    	}
        	);
        }
    };

}();

jQuery(document).ready(function() {
    Login.init();
});