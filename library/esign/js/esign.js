
$(document).ready(function(){
        $('a[name=esign_modal]').live("click", function(e){
            //Cancel the link behavior
		e.preventDefault();
		
		//Get the A tag
		var id = $(this).attr('href');
	
		//Get the screen height and width
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();
	
		//Set heigth and width to mask to fill up the whole screen
		$('#mask').css({'width':maskWidth,'height':maskHeight});
		
		//transition effect		
		$('#mask').fadeIn(200);	
		$('#mask').fadeTo("fast",0.5);	
	
		//Get the window height and width
		var winH = $(window).height();
		var winW = $(window).width();
              
		//Set the popup window to center
		$(id).css('top',  winH/4-$(id).height()/4);
		$(id).css('left', winW/2-$(id).width()/2);
	
		//transition effect
		$(id).fadeIn(200); 
        });
	
        
	//if close button is clicked
	$('.window .close').live('click', function (e) {
		//Cancel the link behavior
		e.preventDefault();
		
		$('#mask').hide();
		$('.window').hide();
	});		
	
	//if mask is clicked
	$('#mask').live('click', function () {
		$(this).hide();
		$('.window').hide();
	});			

	$(window).live('resize', function () {
	 
 		var box = $('.window');
 
        //Get the screen height and width
        var maskHeight = $(document).height();
        var maskWidth = $(window).width();
      
        //Set height and width to mask to fill up the whole screen
        $('#mask').css({'width':maskWidth,'height':maskHeight});
        
        //Get the window height and width
        var winH = $(window).height();
        var winW = $(window).width();

        //Set the popup window to center
        box.css('top',  winH/2 - box.height()/2);
        box.css('left', winW/2 - box.width()/2);
	 
	});
    });

var esign = {
	
    getESignatureLog:function(form_dir, form_id)
    {
        params = {
            form_dir : form_dir ,
            form_id : form_id
        };
        var log_container = "#" + form_dir + "_" + form_id + "_signature_log";
        
        $(log_container).html("");

        // get number of attacks for the character
        $.tzPOST('getESignatureLog', params, function(r){
            if(r == null)
            {
                alert("no json data; r is null");
                return;
            }
               
            $(log_container).html(r.html);
        });
    },
    processESignature:function(form_dir, form_id){
        if ($("#login_pass").val().length <1) 
        {
            alert("You must enter a password");
            return false;
        }
        
        params = {
            password : $("#login_pass").val(),
            form_dir : form_dir,
            form_id : form_id
        };
        
        $('#mask_content').html("");

        // get number of attacks for the character
        $.tzPOST('processESignature', params, function(r){
            if(r == null)
            {
                alert("no json data; r is null");
                return;
            }
               
            $('#mask_content').html(r.html);
        });
        
        var timeout = 3000;
        $('#mask_content').fadeOut(timeout);	
	$('#mask_content').fadeTo(timeout, 0);
        
        $('#mask_content').html("");
        $('#mask').fadeOut(timeout);	
	$('#mask').fadeTo(timeout, 0);
        
        this.getESignatureLog(form_dir, form_id);
    },
    getESignatureForm:function(){
        params = {};
        
        $('#mask_content').html("");

        // get number of attacks for the character
        $.tzPOST('getESignatureForm', params, function(r){
            if(r == null)
            {
                alert("no json data; r is null");
                return;
            }
               
            $('#mask_content').html(r.html);
        });
    },
    getESignaturePrompt:function(e){
        params = {
            form_dir : e.getAttribute('formdir'),
            form_id : e.getAttribute('formid')
        };
        
        $('#mask_content').html("");

        // get number of attacks for the character
        $.tzPOST('getESignaturePrompt', params, function(r){
            if(r == null)
            {
                alert("no json data; r is null");
                return;
            }
               
            $('#mask_content').html(r.html);
        });
    }
};

// Custom GET & POST wrappers:

$.tzPOST = function(action,data,callback){
    $.post('../../../library/esign/ajax/ajax.php?action='+action,data,callback,'json');
};

$.tzGET = function(action,data,callback){
    $.get('../../../library/esign/ajax/ajax.php?action='+action,data,callback,'json');
};

// A custom jQuery method for placeholder text:

$.fn.defaultText = function(value){
	
    var element = this.eq(0);
    element.data('defaultText',value);
	
    element.focus(function(){
        if(element.val() === value){
            element.val('').removeClass('defaultText');
        }
    }).blur(function(){
        if(element.val() === '' || element.val() === value){
            element.addClass('defaultText').val(value);
        }
    });
	
    return element.blur();
};

