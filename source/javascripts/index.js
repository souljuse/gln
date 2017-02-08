// This is where it all goes :)
var jQuery = require("jquery");
global.jQuery = jQuery;
require('bxslider');

var $ = jQuery;

$(document).ready(function(){
  $('.bxslider').bxSlider();
});

$('#main-nav-toggler').on('click', function(e) {
  e.preventDefault();
  $(this).parent().toggleClass('is-active');
});
