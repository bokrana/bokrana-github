jQuery(document).ready(function($) {

// Navigational Menu ddsmoothmenu
//ddsmoothmenu.init({
//	mainmenuid: "menu", //menu DIV id
//	orientation: 'h', //Horizontal or vertical menu: Set to "h" or "v"
//	classname: 'navigation', //class added to menu's outer DIV
//	contentsource: "markup" //"markup" or ["container_id", "path_to_menu_file"]
//})
// Carousel slider
// works hover effect 
// Tooltips
/* Adding a colortip to any tag with a data attribute: */
//$('[data]').colorTip({color:'yellow'});
// UItoTop plugin 	
//$().UItoTop({ easingType: 'easeOutQuart' });
 
// reponsive menu
$("#menu > a").click(function () {
      $("#menu > ul").slideToggle("fast");
});

(function ($) {
$('#menu > a').bind('click', function () {
  if ($(this).hasClass('current')) {
	  $(this).removeClass('current');
	  $(this).parent().parent().find('#menu > ul').slideUp('fast');
	  
	  return false;
  } else {
	  $(this).addClass('current');
	  $('#menu').removeClass('navigation');
	  $('#menu').addClass('responsive');
	  $(this).parent().parent().find('#menu > ul').slideDown('fast');
	  
	  return false;
  }
} );


$(window).bind('resize', function () { 
  if ($(this).width() > 959) {
	  $('#menu > a').removeClass('current');
	  $('#menu').removeClass('responsive');
	  $('#menu').addClass('navigation');
	  $('#menu > ul').removeAttr('style');
  } else {
	  $('#menu').removeClass('navigation');
	  $('#menu').addClass('responsive');  
  }
} );
} )(jQuery);


// Touch-friendly drop-down navigation
$( '#menu li:has(ul)' ).doubleTapToGo();

$(function() {
    $('#menu a').each(function() {
        if ( $(this).parent('li').children('ul').size() > 0 ) {
            $(this).append('<i class="icon-angle-down responsive"></i>');
        }           
    });
});

$("a.down-button").click(function () {
      $(".slidedown").slideToggle("slow");
});

// top bar show & hide
(function ($) {
$('a.down-button').bind('click', function () {
  if ($(this).hasClass('current')) {
	  $(this).removeClass('current');
	  $('a.down-button > i').removeClass('icon-angle-up');
	  $('a.down-button > i').addClass('icon-angle-down');
	  $(this).parent().parent().find('.slidedown').slideUp('slow');
	  
	  return false;
  } else {
	  $(this).addClass('current');
	  $('a.down-button > i').removeClass('icon-angle-down');
	  $('a.down-button > i').addClass('icon-angle-up');
	  $(this).parent().parent().find('.slidedown').slideDown('slow');
	  
	  return false;
  }
} );


$(window).bind('resize', function () { 
  if ($(this).width() > 768) {
	  $('a.down-button').removeClass('current');
	  $('a.down-button > i').removeClass('icon-angle-up');
	  $('a.down-button > i').addClass('icon-angle-down');
	  $('.slidedown').removeAttr('style');
  }
} );
} )(jQuery);

// Progress Bar
// tytabs
// Alert Boxes
// Flex Slider
/* FancyBox plugin */
//$('.fancybox').fancybox({
//prevEffect : 'none',
//nextEffect : 'none',
//loop : false
//});
/* header fixed with sticky plugin */
//$("header.fixed .main-header").sticky({ topSpacing: 0 });
/* this for header 3 and 5
$("header.fixed .down-header").sticky({ topSpacing: 0 });
*/
//$('.sticky-wrapper').removeAttr('style');
								
});
