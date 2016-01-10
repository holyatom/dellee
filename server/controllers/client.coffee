Controller = require('../base/controller')
AppRouter = require('app/router')
AdminRouter = require('admin/router')


class ClientController extends Controller
  logPrefix: '[client controller]'

  router: ->
    AppRouter::route = AdminRouter::route = (url) =>
      return if url.indexOf('*') >= 0

      @get url, (req, res, next) ->
        @middlewares.clientRender(req, res)

    (new AppRouter()).router()
    (new AdminRouter()).router()

module.exports = new ClientController()
