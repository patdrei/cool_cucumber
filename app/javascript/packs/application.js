// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
import { shopping_list_item_listener } from '../shopping_list_items.js';
import { pref_toggler } from '../preferences.js';
import { rotator } from '../rotator.js';
import { range_slider } from '../range_slider.js';
import { shuffle_delete } from '../shuffle_delete.js';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  shopping_list_item_listener();
});

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  pref_toggler();
});

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  shuffle_delete();
});

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  rotator();
});

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  range_slider();
});

//= require burgermenu
$(document).ready(function() {
  $(document).delegate('.open', 'click', function(event){
      $(this).addClass('oppenned');
      event.stopPropagation();
  })
  $(document).delegate('body', 'click', function(event) {
      $('.open').removeClass('oppenned');
  })
  $(document).delegate('.cls', 'click', function(event){
      $('.open').removeClass('oppenned');
      event.stopPropagation();
  });
});

$(".alert").fadeTo(2000, 500).slideUp(500, function(){
    $(".alert").slideUp(1000);
});


