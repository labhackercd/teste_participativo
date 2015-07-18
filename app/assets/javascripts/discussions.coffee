# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.button-collapse').sideNav()
  $.ajax
    type: 'GET'
    url: "/discussions/layout"
    dataType: 'script'
    data: {'id': gon.discussion_id.$oid},
    success: (data) ->
    error: (result) ->
      console.log 'error'



