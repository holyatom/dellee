$ = require('jquery')
_ = require('lodash')
Backbone = require('backbone')
config = require('config')
location = require('lib/location')
urlQuery = require('lib/url_query')


module.exports = class Collection extends Backbone.Collection
  baseUrl: -> _.result(@, 'apiRoot') + _.result(@, 'urlPath')

  apiRoot: config.api_root
  urlPath: null
  $: $.ajax

  idAttribute: '_id'

  paginationDefaults:
    page: 1
    perPage: 20

  initialize: ->
    @initDefaults()
    super

  reset: ->
    super
    @initDefaults()

  initDefaults: ->
    _.defaults(@pagination = {}, @paginationDefaults)

  url: ->
    url = _.result(@, 'baseUrl')

    params =
      per_page: @pagination.perPage
      page: @pagination.page

    urlQuery(url, params)

  parse: (resp)->
    @pagination.total = resp.total
    @pagination.totalPage = Math.ceil(@pagination.total / @pagination.per_page)

    resp.collection

  toJSON: ->
    { collection: super(), @pagination }
