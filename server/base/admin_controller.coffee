ModelController = require('./model_controller')


module.exports = class AdminController extends ModelController
  apiPrefix: '/api/admin'

  middleware: ->
    baseUrl = "#{@apiPrefix}#{@urlPrefix}"

    @_router.use(baseUrl, @middlewares.adminAuth) if @auth
    @_router.use(baseUrl, @middlewares.requireAdminRoles(@roles)) if @roles

  addHandlers: (handler, handlers) ->
    handlers.push(@middlewares.adminAuth) if handler.auth
    handlers.push(@middlewares.requireAdminRoles(handler.roles)) if handler.roles
