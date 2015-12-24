# DO NOT TOUCH. Has to be this way
global.$ = global.jQuery = require('jquery') # for plugins to work w/o shimming
global._ = require('lodash') # for backbone plugins to work

global.Backbone = require('backbone') # for backbone plugins to work
global.Backbone.$ = global.$

$.ajaxSetup(
  crossDomain: true
  dataType: 'json'
  contentType: "application/json"
  processData: false
  beforeSend: ->
    if _.isObject(@data) and @type.toLowerCase() isnt 'get'
      @data = JSON.stringify(@data)
)
