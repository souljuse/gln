// This is where it all goes :)
var jQuery = require("jquery");
global.jQuery = jQuery;
require('bxslider');

var $ = jQuery;

$(document).ready(function(){
  $('.bxslider').bxSlider();

  var frameHeight = $(window).height();
  $('.main-frame').css('min-height', frameHeight);

  var windowHeight = $(window).height();

  if ($(window).width() >= 1024) {
    var windowHeight = $(window).height();
    var headerHeight = $('.header').height();
    var heroHeight = (windowHeight-96);
    $('.hero__body').height(heroHeight);
  }

  var top = heroHeight/2;
  $('.main-nav__first-level__item--stick-left').css('top', top);
  $('.main-nav__first-level__item--stick-right').css('top', top);

  //form submission with FormSpree
  $("#contacts-form").submit(function(e) {

      var url = "https://formspree.io/info@florenceluxuryvillas.com";

      $.ajax({
             type: "POST",
             url: url,
             data: $("#contacts-form").serialize(),
             success: function(data)
             {
                alert("Request sent.");
                goog_snippet_vars = function() {
                  var w = window;
                  w.google_conversion_id = 851423657;
                  w.google_conversion_label = "t-ENCIu9z3EQqeP-lQM";
                  w.google_remarketing_only = false;
                }
                // DO NOT CHANGE THE CODE BELOW.
                goog_report_conversion = function(url) {
                  goog_snippet_vars();
                  window.google_conversion_format = "3";
                  var opt = new Object();
                  opt.onload_callback = function() {
                  if (typeof(url) != 'undefined') {
                    window.location = url;
                  }
                }
                var conv_handler = window['google_trackConversion'];
                if (typeof(conv_handler) == 'function') {
                  conv_handler(opt);
                }
                }
             }
           });

      e.preventDefault();
  });
});

$('#main-nav-toggler').on('click', function(e) {
  e.preventDefault();
  $(this).parent().toggleClass('is-active');
});

$('.js-cta').on('click', function(e) {
  goog_snippet_vars = function() {
    var w = window;
    w.google_conversion_id = 851423657;
    w.google_conversion_label = "LOWhCISoyXEQqeP-lQM";
    w.google_remarketing_only = false;
  }
  // DO NOT CHANGE THE CODE BELOW.
  goog_report_conversion = function(url) {
    goog_snippet_vars();
    window.google_conversion_format = "3";
    var opt = new Object();
    opt.onload_callback = function() {
    if (typeof(url) != 'undefined') {
      window.location = url;
    }
  }
  var conv_handler = window['google_trackConversion'];
  if (typeof(conv_handler) == 'function') {
    conv_handler(opt);
  }
}
});
