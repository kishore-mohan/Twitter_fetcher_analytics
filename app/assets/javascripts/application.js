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
//= require turbolinks
//= require bootstrap
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function() {
  $('.score-tooltip').tooltip({html: true});

  var previousBlock = undefined;
  var previousPosition = 'right';
  $.each($('#tweets-timeline-wrapper ul li'), function(i, block){
    block = $(block);

    if (previousBlock && previousBlock.height() < block.height()) {
      block.addClass(previousPosition);
    }
    else {
      if (i == 2 && previousBlock.height() == block.height())
        block.addClass(previousPosition);
      else {
        position = previousPosition == 'right' ? 'left' : 'right';
        block.addClass(position);
        previousPosition = position;
      }
    }

    previousBlock = block;
  })
});
