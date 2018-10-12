// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require Chart.bundle
//= require chartkick
//= require jquery3
//= require jquery_ujs
//= require rails-ujs
//= require pagy
//= require popper
//= require trix
//= require bootstrap-sprockets
//= require serviceworker-companion
//= require ahoy
//= require jquery.easy-autocomplete
//= require unveil
//= require bootstrap-select
//= require bootstrap/alert
//= require bootstrap/dropdown
//= require_tree .

window.addEventListener("turbolinks:load", Pagy.init);

$(document).ready(function(){
  setTimeout(function() {
    $('#notice_wrapper').fadeOut("slow", function() {
      this.remove();
    });
  }, 2000);
});
