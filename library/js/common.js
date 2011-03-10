function tabbify() {

    $('ul.tabNav a').click(function() {
        var curChildIndex = $(this).parent().prevAll().length + 1;
        $(this).parent().parent().children('.current').removeClass('current');
        $(this).parent().addClass('current');
        $(this).parent().parent().next('.tabContainer').children('.current').each(function() {
            $(this).removeClass('current');
            $(this).parent().children('div:nth-child('+curChildIndex+')').each(function() {
                $(this).addClass('current');
            });
        });
        return false;
    });
    
}

function enable_modals( fWidth, fHeight ) {
  frameWidth = (typeof fWidth == 'undefined') ? 640 : fWidth;
  frameHeight = (typeof fHeight == 'undefined') ? 480 : fHeight;
  
    // fancy box
	$(".iframe").fancybox( {
		'titleShow' : false,
	        'autoScale' : false,
		'showCloseButton' : true,
		'overlayOpacity' : 0.0,
		'frameWidth' : frameWidth,
	        'frameHeight' : frameHeight,
	        'centerOnScroll' : false
    });
}

function enable_modals_1_3( fWidth, fHeight ) {
  frameWidth = (typeof fWidth == 'undefined') ? 640 : fWidth;
  frameHeight = (typeof fHeight == 'undefined') ? 480 : fHeight;
  
    // fancy box
	$(".iframe").fancybox( {
		'overlayOpacity' : 0.0,
		'showCloseButton' : true,
	        'height' : frameHeight,
		'width' : frameWidth,
		'transitionOut' : 'none',
		'transitionIn' : 'none',
		'autoscale' : false,
	        'centerOnScroll' : false
    });
}

function enable_big_modals() {
  // Requires fancybox 1.3.4 or better.
  $(".iframe").fancybox({
    'width'         : '99%',
    'height'        : '99%',
    'autoScale'     : false,
    'type'          : 'iframe'
  });
}

//----------------------------------------
function PreventIt(evt)//Specially for the browser chrome.
 {//When focus is on the text box and enter key is pressed the form gets submitted.TO prevent it this function is used.
	evt = (evt) ? evt : window.event;
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	if (charCode == 13)//tab key,enter key
	 {
		if (evt.preventDefault) evt.preventDefault();
		if (evt.stopPropagation) evt.stopPropagation();
	 }
}

//
// To be used as keypress handler for Numeric-only text fields.
//
function number_filter(event) {
  var keyCode = (event.which) ? event.which : event.keyCode;
  return ((keyCode >= 0x30 && keyCode <= 0x39)  || // '0' - '9'
 	   keyCode == 8  || keyCode == 9    || // BS, HT
	   keyCode == 12 || keyCode == 27   || // Clear, ESC
	   keyCode == 37 || keyCode == 39   || // Left-Arrow, Right-Arrow
           keyCode == 46);                     // Del
 }

