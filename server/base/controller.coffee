_ = require('lodash')
router = require('express').Router()
middlewares = require('../middlewares')


class Controller
  # Please set this on the instance
  logPrefix: '[base controller]'
  log: require('lib/logger')

  middlewares: middlewares
  error: middlewares.error
  notFound: middlewares.notFound

  constructor: ->
    @_router = router

  _bind: (callbacks)->
    if _.isArray(callbacks)
      _.bind(callback, @) for callback in callbacks
    else
      _.bind(callbacks, @)

  _handler: (type, route, callbacks...)-> @_router[type](route, @_bind(callbacks)...)

  get: (route, callbacks...)-> @_handler('get', route, callbacks...)
  post: (route, callbacks...)-> @_handler('post', route, callbacks...)
  head: (route, callbacks...)-> @_handler('head', route, callbacks...)
  put: (route, callbacks...)-> @_handler('put', route, callbacks...)
  delete: (route, callbacks...)-> @_handler('delete', route, callbacks...)
  all: (route, callbacks...)-> @_handler('all', route, callbacks...)

  use: (@app)->
    @middleware?()
    @router?()

    @app.use(@_router)

    @log('initialized', 'cyan')

module.exports = Controller
