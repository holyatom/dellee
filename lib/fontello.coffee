needle = require('needle')

HOST = 'http://fontello.com'


module.exports =
  apiRequest: (options, successCallback, errorCallback) ->
    options.host ?= HOST

    requestOptions = multipart: true
    requestOptions.proxy = options.proxy if options.proxy?

    data =
      config:
        file: options.config
        content_type: 'application/json'

    needle.post options.host, data, requestOptions, (error, response, body) ->
      throw error if error
      sessionId = body

      if response.statusCode is 200
        sessionUrl = "#{options.host}/#{sessionId}"
        successCallback? sessionUrl
      else
        errorCallback? response
