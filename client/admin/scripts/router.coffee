BaseRouter = require('./base/router')
vent = require('./modules/vent')
profile = require('./modules/profile')


module.exports = class Router extends BaseRouter
  run: ->
    super

    vent.on('user:login', => @routeTo('/admin/dashboard'))
    vent.on('user:logout', => @routeTo('/admin'))

  router: ->
    @route('/admin', 'home.index')
    @route('/admin/dashboard', 'dashboard.index')

    @route('/admin/*', 'notFound.index')

if process.browser
  Router::controllers =
    home: require('./controllers/home')
    dashboard: require('./controllers/dashboard')
    notFound: require('./controllers/not_found')
