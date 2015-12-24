Controller = require('../base/controller')


class ClientController extends Controller
  logPrefix: '[client controller]'

  renderAppView: (req, res, next) ->
    res.render('layout_app', layout: false)

  renderAdminView: (req, res, next) ->
    res.render('layout_admin', layout: false)

  router: ->
    @get('/', @renderAppView)
    @get('/admin', @renderAdminView)

module.exports = new ClientController()
