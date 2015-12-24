_ = require('lodash')
$ = require('jquery')
Backbone = require('backbone')
config = require('config')


module.exports = class Model extends Backbone.Model
  apiRoot: config.api_root
  urlPath: null
  $: $.ajax
  idAttribute: '_id'

  resourceUrl: ->
    url = _.result(@, 'urlPath')
    url += "/#{@id}" if @id
    url

  url: ->
    _.result(@, 'apiRoot') + _.result(@, 'resourceUrl')
