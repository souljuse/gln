// This is where it all goes :)
var jQuery = require("jquery");
global.jQuery = jQuery;
require('bxslider');

var $ = jQuery;

$(document).ready(function(){
  $('.bxslider').bxSlider();
});
