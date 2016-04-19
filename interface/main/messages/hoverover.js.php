<?php
/**
 * javascript code responsible for floating popup message notice generation.
 *
 * Copyright (C) 2012 Julia Longtin <julialongtin@diasp.org>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 *
 * This file is included as an invisible iframe by forms that want to be
 * notified when a new message for the user comes in.
 *
 * @package OpenEMR
 * @author  Julia Longtin <julialongtin@diasp.org>
 * @link    http://open-emr.org
 */


/* for $GLOBALS[]. */
require_once('../../globals.php'); 

/* set the content type. */
header('Content-Type: application/javascript');
?>

var stickyUUIDs = new Array();
var stickycount = 0;

hiddenIFrameload = function () {
    try {
        iframeloaded();
    } catch (e) {
        alert('exception: ' + e);
    }
};

// TODO - make this a Global config for the interval seconds
setInterval(function () {
    $('#hiddenIFrame').attr('src', "<?php echo $GLOBALS['webroot']; ?>/interface/main/messages/message_status.php?skip_timeout_reset=1");
}, 30000);

iframeloaded = function () {
    if ($('#hiddenIFrame').contents().find('#notices').text()) {
        var noticecount = $('#hiddenIFrame').contents().find('#noticecount').text();
        if (noticecount > 0) {
            for (var i = 0; i < noticecount; i++) {
                var parsenotice = $('#hiddenIFrame').contents().find('#notice' + i);
                if (parsenotice.find('.sticky').text() != "") {
                    var foundUUID = 0;
                    for (var j = 0; j <= stickycount; j++) {
                        if (stickyUUIDs[j] == parsenotice.find('.UUID').text()) {
                            foundUUID = 1;
                        }
                    }
                    ;
                    if (foundUUID == 0) {
                        stickyUUIDs[j] = parsenotice.find('.UUID').text();
                        stickycount++;
                        $.gritter.add({
                            title: '<span class="' + parsenotice.find('.colour').text() + '">' + parsenotice.find('.title').text() + '</span>',
                            text: parsenotice.find('.text').text(),
                            sticky: parsenotice.find('.sticky').text(),
                            time: '5000',
                            class_name: 'notice' + i + 'class'
                        });
                    }
                }
                else {
                    $.gritter.add({
                        title: '<span class="' + parsenotice.find('.colour').text() + '">' + parsenotice.find('.title').text() + '</span>',
                        text: parsenotice.find('.text').text(),
                        sticky: parsenotice.find('.sticky').text(),
                        time: '5000',
                        class_name: 'notice' + i + 'class'
                    });
                }
                ;
            }
            ;
        }
        ;
    }
    ;
};
$(function () {
    $('<iframe style="width:0px;height:0px;border:0px;" id="hiddenIFrame" onload="hiddenIFrameload()" src="<?php echo $GLOBALS['webroot']; ?>/interface/main/messages/message_status.php"/>').appendTo('body');
    $('#hiddenIFrame').attr('src', "<?php echo $GLOBALS['webroot']; ?>/interface/main/messages/message_status.php?skip_timeout_reset=1");
});
