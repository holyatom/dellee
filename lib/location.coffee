_ = require('underscore')
querystring = require('querystring')


module.exports =
  getParams: ->
    querystring.parse(global.location.search.slice(1))

  overrideUrl: (url, params) ->
    oldParams = @getParams()
    _.extend(oldParams, params)
    delete oldParams[key] for key, value of params when not value?

    url += "?#{query}" if query = querystring.stringify(oldParams)
    url
