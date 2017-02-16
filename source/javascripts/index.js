// This is where it all goes :)
var jQuery = require("jquery");
global.jQuery = jQuery;
require('bxslider');

var $ = jQuery;

$(document).ready(function(){
  $('.bxslider').bxSlider();

  var frameHeight = $(window).height();
  $('.main-frame').css('min-height', frameHeight);

  var heroHeight = $('.hero').height();
  var top = heroHeight/2;
  $('.main-nav__first-level__item--stick-left').css('top', top);
  $('.main-nav__first-level__item--stick-right').css('top', top);


  $("#contacts-form").submit(function(e) {

      var url = "https://formspree.io/t.valentini@cantierecreativo.net";

      $.ajax({
             type: "POST",
             url: url,
             data: $("#contacts-form").serialize(),
             success: function(data)
             {
                 alert("Request successfully sent!");
             }
           });

      e.preventDefault();
  });


});

$('#main-nav-toggler').on('click', function(e) {
  e.preventDefault();
  $(this).parent().toggleClass('is-active');
});
