// This is where it all goes :)
var jQuery = require("jquery");
global.jQuery = jQuery;
require('bxslider');

jQuery(document).ready(function(){
  jQuery('.bxslider').bxSlider();
});

$('#main-nav-toggler').on('click', function(e) {
  e.preventDefault();
  $(this).parent().toggleClass('is-active');
});
