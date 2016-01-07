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
    super
    @initParams()

  url: ->
    url = _.result(@, 'baseUrl')

    params =
      per_page: @pagination.perPage
      page: @pagination.page

    urlQuery(url, params)

  parse: (resp)->
    @pagination.total = resp.total
    @pagination.totalPage = Math.ceil(@pagination.total / @pagination.perPage)

    resp.collection

  toJSON: ->
    { collection: super(), canPaginate: @canPaginate(), @pagination, @fields, @fieldNames, @fieldFormats, @idAttribute }

  reset: ->
    super
    @initParams()

  getQueryParams: ->
    qs = location.getParams()
    pagination = {}

    if qs.page and page = parseInt(qs.page, 10)
      pagination.page = page

    if qs.per_page and per_page = parseInt(qs.per_page, 10)
      pagination.perPage = per_page

    # return
    { pagination }

  initParams: ->
    { @pagination } = @getQueryParams()

    _.defaults(@pagination, @paginationDefaults)

  canPaginate: ->
    @pagination.totalPage not in [0, 1]
