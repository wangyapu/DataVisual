/**
  @license html2canvas v0.34 <http://html2canvas.hertzen.com>
  Copyright (c) 2011 Niklas von Hertzen. All rights reserved.
  http://www.twitter.com/niklasvh

  Released under MIT License
 */
/*
 * jQuery helper plugin for examples and tests
 */
(function( $ ){
    $.fn.html2canvas = function(options,callback) {
        if (options && options.profile && window.console && window.console.profile) {
            console.profile();
        }
        options = options || {};

        options.onrendered = options.onrendered || function( canvas ) {
            var $canvas = $(canvas);

            if (options && options.profile && window.console && window.console.profileEnd) {
                console.profileEnd();
            }
        

            // test if canvas is read-able
            try {
                var imgData = $canvas[0].toDataURL();
          		var w = $canvas[0].width,
          			h = $canvas[0].height;
                callback(imgData, w, h);
            } catch(e) {
                if ($canvas[0].nodeName.toLowerCase() === "canvas") {
                    // TODO, maybe add a bit less offensive way to present this, but still something that can easily be noticed
                    alert("Canvas is tainted, unable to read data");
                }
            }
        };

        html2obj = html2canvas(this, options);
    };
})( jQuery );

