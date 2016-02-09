// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.easing.1.3.min
//= require jquery-ui/jquery.ui.core
//= require jquery-ui/jquery.ui.widget
//= require jquery-ui/jquery.ui.accordion
//= require my-java/jquery.mixitup
//= require my-java/jquery.mixitup-pagination
//= require my-java/jquery.knob.min
//= require my-java/typeahead.min
//= require my-java/sweetalert2
//= require my-java/jquery.spritely
//= require my-java/jQuery-Form-Validator/jquery.form-validator
//= require my-java/bootstrap-modal
//= require  my-java/doubletaptogo
//= require  my-java/html5tooltips
//= require  my-java/toastr
//= require jquery.remotipart
//= require custom
//= require_self
//= require turbolinks

//======================aiman=================================
// see more - aiman -- from http://viralpatel.net/blogs/dynamically-shortened-text-show-more-link-jquery/
 /*
 * jQuery Shorten plugin 1.0.0
 *
 * Copyright (c) 2013 Viral Patel
 * http://viralpatel.net
 *
 * Dual licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 */

 (function($) {
	$.fn.shorten = function (settings) {
	
		var config = {
			showChars: 500,
			ellipsesText: "...",
			moreText: "more",
			lessText: "less"
		};

		if (settings) {
			$.extend(config, settings);
		}
		
		$(document).off("click", '.morelink');
		
		$(document).on({click: function () {

				var $this = $(this);
				if ($this.hasClass('less')) {
					$this.removeClass('less');
					$this.html(config.moreText);
				} else {
					$this.addClass('less');
					$this.html(config.lessText);
				}
				$this.parent().prev().toggle();
				$this.prev().toggle();
				return false;
			}
		}, '.morelink');

		return this.each(function () {
			var $this = $(this);
			if($this.hasClass("shortened")) return;
			
			$this.addClass("shortened");
			var content = $this.html();
			if (content.length > config.showChars) {
				var c = content.substr(0, config.showChars);
				var h = content.substr(config.showChars, content.length - config.showChars);
				var html = c + '<span class="moreellipses">' + config.ellipsesText + ' </span><span class="morecontent"><span>' + h + '</span> <a href="#" class="morelink">' + config.moreText + '</a></span>';
				$this.html(html);
				$(".morecontent span").hide();
			}
		});
		
	};

 })(jQuery);
//======================================================================
//proton-live-notification=====================================

// end=====================================================
/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <jevin9@gmail.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return. Jevin O. Sewaruth
 * ----------------------------------------------------------------------------
 *
 * Autogrow Textarea Plugin Version v3.0
 * http://www.technoreply.com/autogrow-textarea-plugin-3-0
 * 
 * THIS PLUGIN IS DELIVERD ON A PAY WHAT YOU WHANT BASIS. IF THE PLUGIN WAS USEFUL TO YOU, PLEASE CONSIDER BUYING THE PLUGIN HERE :
 * https://sites.fastspring.com/technoreply/instant/autogrowtextareaplugin
 *
 * Date: October 15, 2012
 */
jQuery.fn.autoGrow = function() {
	return this.each(function() {

		var createMirror = function(textarea) {
			jQuery(textarea).after('<div class="autogrow-textarea-mirror"></div>');
			return jQuery(textarea).next('.autogrow-textarea-mirror')[0];
		}

		var sendContentToMirror = function (textarea) {
			mirror.innerHTML = String(textarea.value)
				.replace(/&/g, '&amp;')
				.replace(/"/g, '&quot;')
				.replace(/'/g, '&#39;')
				.replace(/</g, '&lt;')
				.replace(/>/g, '&gt;')
				.replace(/ /g, '&nbsp;')
				.replace(/\n/g, '<br />') +
				'.<br/>.'
			;

			if (jQuery(textarea).height() != jQuery(mirror).height())
				jQuery(textarea).height(jQuery(mirror).height());
		}

		var growTextarea = function () {
			sendContentToMirror(this);
		}

		// Create a mirror
		var mirror = createMirror(this);
		
		// Style the mirror
		mirror.style.display = 'none';
		mirror.style.wordWrap = 'break-word';
		mirror.style.whiteSpace = 'normal';
		mirror.style.padding = jQuery(this).css('padding');
		mirror.style.width = jQuery(this).css('width');
		mirror.style.fontFamily = jQuery(this).css('font-family');
		mirror.style.fontSize = jQuery(this).css('font-size');
		mirror.style.lineHeight = jQuery(this).css('line-height');

		// Style the textarea
		this.style.overflow = "hidden";
		this.style.minHeight = "108px";

		// Bind the textarea's event
		this.onkeyup = growTextarea;

		// Fire the event for text already present
		sendContentToMirror(this);
	});
};
//=============================================================
//-Timeago=====================================================
/**
 * Timeago is a jQuery plugin that makes it easy to support automatically
 * updating fuzzy timestamps (e.g. "4 minutes ago" or "about 1 day ago").
 *
 * @name timeago
 * @version 0.11.4
 * @requires jQuery v1.2.3+
 * http://timeago.yarp.com/
 */
 (function (factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module.
    define(['jquery'], factory);
  } else {
    // Browser globals
    factory(jQuery);
  }
}(function ($) {
  $.timeago = function(timestamp) {
    if (timestamp instanceof Date) {
      return inWords(timestamp);
    } else if (typeof timestamp === "string") {
      return inWords($.timeago.parse(timestamp));
    } else if (typeof timestamp === "number") {
      return inWords(new Date(timestamp));
    } else {
      return inWords($.timeago.datetime(timestamp));
    }
  };
  var $t = $.timeago;

  $.extend($.timeago, {
    settings: {
      refreshMillis: 60000,
      allowFuture: false,
      localeTitle: true,
      cutoff: 0,
      strings: {
        prefixAgo: null,
        prefixFromNow: null,
        suffixAgo: "ago",
        suffixFromNow: "from now",
        seconds: "less than a minute",
        minute: "about a minute",
        minutes: "%d minutes",
        hour: "about an hour",
        hours: "about %d hours",
        day: "a day",
        days: "%d days",
        month: "about a month",
        months: "%d months",
        year: "about a year",
        years: "%d years",
        wordSeparator: " ",
        numbers: []
      }
    },
    inWords: function(distanceMillis) {
      var $l = this.settings.strings;
      var prefix = $l.prefixAgo;
      var suffix = $l.suffixAgo;
      if (this.settings.allowFuture) {
        if (distanceMillis < 0) {
          prefix = $l.prefixFromNow;
          suffix = $l.suffixFromNow;
        }
      }

      var seconds = Math.abs(distanceMillis) / 1000;
      var minutes = seconds / 60;
      var hours = minutes / 60;
      var days = hours / 24;
      var years = days / 365;

      function substitute(stringOrFunction, number) {
        var string = $.isFunction(stringOrFunction) ? stringOrFunction(number, distanceMillis) : stringOrFunction;
        var value = ($l.numbers && $l.numbers[number]) || number;
        return string.replace(/%d/i, value);
      }

      var words = seconds < 45 && substitute($l.seconds, Math.round(seconds)) ||
        seconds < 90 && substitute($l.minute, 1) ||
        minutes < 45 && substitute($l.minutes, Math.round(minutes)) ||
        minutes < 90 && substitute($l.hour, 1) ||
        hours < 24 && substitute($l.hours, Math.round(hours)) ||
        hours < 42 && substitute($l.day, 1) ||
        days < 30 && substitute($l.days, Math.round(days)) ||
        days < 45 && substitute($l.month, 1) ||
        days < 365 && substitute($l.months, Math.round(days / 30)) ||
        years < 1.5 && substitute($l.year, 1) ||
        substitute($l.years, Math.round(years));

      var separator = $l.wordSeparator || "";
      if ($l.wordSeparator === undefined) { separator = " "; }
      return $.trim([prefix, words, suffix].join(separator));
    },
    parse: function(iso8601) {
      var s = $.trim(iso8601);
      s = s.replace(/\.\d+/,""); // remove milliseconds
      s = s.replace(/-/,"/").replace(/-/,"/");
      s = s.replace(/T/," ").replace(/Z/," UTC");
      s = s.replace(/([\+\-]\d\d)\:?(\d\d)/," $1$2"); // -04:00 -> -0400
      s = s.replace(/([\+\-]\d\d)$/," $100"); // +09 -> +0900
      return new Date(s);
    },
    datetime: function(elem) {
      var iso8601 = $t.isTime(elem) ? $(elem).attr("datetime") : $(elem).attr("title");
      return $t.parse(iso8601);
    },
    isTime: function(elem) {
      // jQuery's `is()` doesn't play well with HTML5 in IE
      return $(elem).get(0).tagName.toLowerCase() === "time"; // $(elem).is("time");
    }
  });

  // functions that can be called via $(el).timeago('action')
  // init is default when no action is given
  // functions are called with context of a single element
  var functions = {
    init: function(){
      var refresh_el = $.proxy(refresh, this);
      refresh_el();
      var $s = $t.settings;
      if ($s.refreshMillis > 0) {
        this._timeagoInterval = setInterval(refresh_el, $s.refreshMillis);
      }
    },
    update: function(time){
      var parsedTime = $t.parse(time);
      $(this).data('timeago', { datetime: parsedTime });
      if($t.settings.localeTitle) $(this).attr("title", parsedTime.toLocaleString());
      refresh.apply(this);
    },
    updateFromDOM: function(){
      $(this).data('timeago', { datetime: $t.parse( $t.isTime(this) ? $(this).attr("datetime") : $(this).attr("title") ) });
      refresh.apply(this);
    },
    dispose: function () {
      if (this._timeagoInterval) {
        window.clearInterval(this._timeagoInterval);
        this._timeagoInterval = null;
      }
    }
  };

  $.fn.timeago = function(action, options) {
    var fn = action ? functions[action] : functions.init;
    if(!fn){
      throw new Error("Unknown function name '"+ action +"' for timeago");
    }
    // each over objects here and call the requested function
    this.each(function(){
      fn.call(this, options);
    });
    return this;
  };

  function refresh() {
    var data = prepareData(this);
    var $s = $t.settings;

    if (!isNaN(data.datetime)) {
      if ( $s.cutoff == 0 || distance(data.datetime) < $s.cutoff) {
        $(this).text(inWords(data.datetime));
      }
    }
    return this;
  }

  function prepareData(element) {
    element = $(element);
    if (!element.data("timeago")) {
      element.data("timeago", { datetime: $t.datetime(element) });
      var text = $.trim(element.text());
      if ($t.settings.localeTitle) {
        element.attr("title", element.data('timeago').datetime.toLocaleString());
      } else if (text.length > 0 && !($t.isTime(element) && element.attr("title"))) {
        element.attr("title", text);
      }
    }
    return element.data("timeago");
  }

  function inWords(date) {
    return $t.inWords(distance(date));
  }

  function distance(date) {
    return (new Date().getTime() - date.getTime());
  }

  // fix for IE6 suckage
  document.createElement("abbr");
  document.createElement("time");
}));
//====================================================================

function previewFile() {
  //var preview = document.querySelector('#drop');
  var file    = document.querySelector('input[type=file]').files[0];
  var reader  = new FileReader();

  reader.onloadend = function () {
    $('#cover-photo-upload').css({'display': 'none'});
    $('#upload').append('<div id="cover-photo-uploaded"><div style="background-image: url('+ reader.result +');" class="cover-photo-holder"></div></div>');
 $('.cover-photo-holder').append('<div class="cover-photo-info"><small class="photo-info-file-name">'+ file.name +'( '+ formatFileSize(file.size) + ')</small><a class="photo-info-delete" onclick = "deletePhoto()" >Delete</a></div>')
  }

  if (file) {
    reader.readAsDataURL(file);
  } else {
    $(".deletephoto").hide();
    $('input[type=file]').val('');
   // preview.src = "/assets/no-profile-image.jpg";
  }

    function formatFileSize(bytes) {
        if (typeof bytes !== 'number') {
            return '';
        }

        if (bytes >= 1000000000) {
            return (bytes / 1000000000).toFixed(2) + ' GB';
        }

        if (bytes >= 1000000) {
            return (bytes / 1000000).toFixed(2) + ' MB';
        }

        return (bytes / 1000).toFixed(2) + ' KB';
    }

}

function deletePhoto () {
	       $('#upload #cover-photo-uploaded').remove();
          $('#upload input[type=file]').val('');
          $('#cover-photo-upload').css({'display': 'block'});
    }
//scroll---totop======================================================
(function($){
$.fn.UItoTop = function(options) {
var defaults = {
text: '<i class="icon-up-open"></i>',
min: 200,
inDelay:600,
outDelay:400,
containerID: 'toTop',
containerHoverID: 'toTopHover',
scrollSpeed: 1200,
easingType: 'linear'
},
settings = $.extend(defaults, options),
containerIDhash = '#' + settings.containerID,
containerHoverIDHash = '#'+settings.containerHoverID;
$('body').append('<a href="#" id="'+settings.containerID+'">'+settings.text+'</a>');
$(containerIDhash).hide().on('click.UItoTop',function(){
$('html, body').animate({scrollTop:0}, settings.scrollSpeed, settings.easingType);
$('#'+settings.containerHoverID, this).stop().animate({'opacity': 0 }, settings.inDelay, settings.easingType);
return false;
})
.prepend('<span id="'+settings.containerHoverID+'"></span>')
.hover(function() {
$(containerHoverIDHash, this).stop().animate({
'opacity': 1
}, 600, 'linear');
}, function() {
$(containerHoverIDHash, this).stop().animate({
'opacity': 0
}, 700, 'linear');
});
$(window).scroll(function() {
var sd = $(window).scrollTop();
if(typeof document.body.style.maxHeight === "undefined") {
$(containerIDhash).css({
'position': 'absolute',
'top': sd + $(window).height() - 50
});
}
if ( sd > settings.min )
$(containerIDhash).fadeIn(settings.inDelay);
else
$(containerIDhash).fadeOut(settings.Outdelay);
});
};
})(jQuery); 

//=my functions=========================================================
function bokranafixed(){
	
	
	$('body').on('click.scrollToTop', 'span.pager', function(event) {
    var $intro = $('#mixitup_result');

    $('html, body').animate({
      scrollTop: $intro.offset().top + $intro.height()
    }, 1000);
  });
	
	
	
	
	
	
	
	
	
	
	
//$( '#profile-control li:has(ul)' ).doubleTapToGo();
$("textarea").autoGrow();
$(".autoShorten").shorten();
$(".timeago").timeago();
$(".icon-clock-1:data(tooltip)").remove();

$('.passionate-profile-link').on("ajax:beforeSend", function(){
$('body').modalmanager('loading');
 }).on("ajax:complete", function(){

 $('.knob').each(function () {
 var $this = $(this);
 var myVal = $this.attr("value");
 $this.knob({'width': 120,'height':120,'readOnly':true,'draw' : function () { 
        $(this.i).val(this.cv + '%')
     }
               });
 $({value: 0}).animate({value: myVal}, { 
               duration: 1800,
               easing: 'swing',
               step: function () {
                   $this.val(Math.ceil(this.value)).trigger('change');}
   });
 });
//----------------------------------------------------------------
 }).on("ajax:error", function(evt, xhr, status, error, exception){
$( '#ajax-modal' ).modal('hide');
$('.modal-scrollable').trigger({ type: "click" });
 })
//====golbal-error======================================================
$(document).on("ajax:error", function(evt, xhr, status, error, exception){
if (xhr.status === 0) {
swal({title: 'Not Connected', text: 'Verify Your Network And Try Again', type: 'error'});
}else if (xhr.status == 400) {
swal({title: 'An error occurred', text: 'Bad Request', type: 'error'});
}else if (xhr.status == 403) {
swal({title: 'Forbidden', text: 'Please Try Again', type: 'error'});
}else if (xhr.status == 404) {
swal({title: 'Requested page not found', text: 'Please Try Again', type: 'error'});
}else if (xhr.status == 408) {
swal({title: 'Request Timeout', text: 'Check Your Connectivity', type: 'error'});
}else if (xhr.status == 422) {
swal({title: 'Unprocessable Entity', text: 'Please Try Again', type: 'error'});
}else if (xhr.status == 500) {
swal({title: 'Internal Server Error 500', text: 'Please Try Again', type: 'error'});
}else if (xhr.status == 503) {
swal({title: 'Service Unavailable', text: 'Please Try Again Later', type: 'error'});
 }else {
swal({title: 'An error occurred while processing the request', text: 'Please Try Again', type: 'error'});
 }
});
//===================================
$('.sweet-alert #sweet-link').on("click", function(){ 
swal.close()
}).on("ajax:beforeSend", function(){
$('body').modalmanager('loading');
 })



}
//=my functions=========================================================
$(document).ajaxComplete(bokranafixed);
$(document).ready(function() { bokranafixed()

$('#home-banner').pan({fps: 30, speed: 0.6, dir: 'right'})


var canvas, stage, exportRoot;
function init() {
canvas = document.getElementById("canvas");
images = images||{};
var manifest = [
{src:"http://d28vnnuaxkcg6l.cloudfront.net/294059-0-cloud.png", id:"cloud"},
{src:"http://d28vnnuaxkcg6l.cloudfront.net/294058-0-rocket.png", id:"rocket_1"}
];
var loader = new createjs.LoadQueue(false);
loader.addEventListener("fileload", handleFileLoad);
loader.addEventListener("complete", handleComplete);
loader.loadManifest(manifest);
}
function handleFileLoad(evt) {
if (evt.item.type == "image") { images[evt.item.id] = evt.result; }
}
function handleComplete() {
exportRoot = new lib.rocket();
stage = new createjs.Stage(canvas);
stage.addChild(exportRoot);
stage.update();
createjs.Ticker.setFPS(30);
createjs.Ticker.addEventListener("tick", stage);
} 

$('body').init() 


$().UItoTop({ easingType: 'easeOutQuart' });
//===============login-dropdownbox=============================
$('#login_button').click(function () {
$('#login-dropdownbox > .login-controller-error').hide();
$('#login-form #email , #login-form #password').removeClass('input-error');
$('#login-form').get(0).reset();
 if ($('#login-dropdownbox').is(":visible")) {
        $('#login-dropdownbox').hide();
    $('#login_button').removeClass('active'); 
    } else {
        $('#login-dropdownbox').show()
      //  $("#login-form > .input-field > input[name='email']").focus();
    $('#login_button').addClass('active'); 
    }
//$('#login-dropdownbox').click(function(e) {
//$('.controller-error').fadeOut();
//$('#login-form #email , #login-form #password').removeClass('input-error');
//});
//$(document).click(function() {
 //   $('#login-dropdownbox').hide();
//$('#login_button').removeClass('active');
//});
});
//=======================================================================
//=====ajax-modal======================================================
//====passion-passionate show + passionate join passion link + header new-passionate-botton============
$('.pp-button , .join_passion,#new-passionate-botton , #new-passionate-botton2, #new_passion_link , #header-passionate-show,#forget-password').on("ajax:beforeSend", function(){
$('body').modalmanager('loading');
 }).on("ajax:complete", function(){
 }).on("ajax:error", function(evt, xhr, status, error, exception){
$( '#ajax-modal' ).modal('hide');
$('.modal-scrollable').trigger({ type: "click" });
//$('#ajax-modal').modal('toggle');
//$('body').removeClass('modal-open');
//$('.modal-backdrop').hide();
//$('.modal-scrollable').hide();
 })
 //===passionate profile=============================================
//$('form').on("ajax:beforeSend", function(){
//$('body').modalmanager('loading');
// }).on("ajax:complete", function(){
//$( '#ajax-modal' ).modal('hide');
//$('.modal-scrollable').trigger({ type: "click" });
 //}).on("ajax:error", function(evt, xhr, status, error, exception){
//$( '#ajax-modal' ).modal('hide');
//$('.modal-scrollable').trigger({ type: "click" });
//$('#ajax-modal').modal('toggle');
//$('body').removeClass('modal-open');
//$('.modal-backdrop').hide();
//$('.modal-scrollable').hide();
// })
//===ajax login form submit button ===========================================================
$('#login-form').on("ajax:beforeSend", function(){
$("#login-form > input[type='submit']").attr('disabled',true);
 }).on("ajax:complete", function(){
 $('#login-form >  input[type="submit"]').removeAttr("disabled")
 })
//===================================================================================

$('.pp-button').hover(function(e){
    e.preventDefault();
    $(this).find('span:first').toggleClass('icon-heart icon-heart-empty');
});

//===================================================================================
















})