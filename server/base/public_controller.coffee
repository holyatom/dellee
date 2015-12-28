ModelController = require('./model_controller')


module.exports = class PublicController extends ModelController
  middleware: ->
    baseUrl = "#{@apiPrefix}#{@urlPrefix}"

    @_router.use(baseUrl, @middlewares.auth) if @auth

  addHandlers: (handler, handlers) ->
    handlers.push(@middlewares.auth) if handler.auth
