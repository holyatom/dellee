BaseRouter = require('./base/router')
vent = require('./modules/vent')
profile = require('./modules/profile')


module.exports = class Router extends BaseRouter
  run: ->
    super

    vent.on('user:login', => @routeTo('/admin/dashboard'))
    vent.on('user:logout', => @routeTo('/admin'))

  auth: (ctx, next) =>
    return @page.redirect('/admin') unless profile.authorized()
    next()

  notAuth: (ctx, next) =>
    return @page.redirect('/admin/dashboard') if profile.authorized()
    next()

  router: ->
    @route('/admin', @notAuth, 'home.index')
    @route('/admin/dashboard', @auth, 'dashboard.index')

    @route('/admin/users', @auth, 'users.index')
    @route('/admin/users/create', @auth, 'users.create')
    @route('/admin/users/:id', @auth, 'users.edit')

    @route('/admin/shops', @auth, 'shops.index')
    @route('/admin/shops/create', @auth, 'shops.create')
    @route('/admin/shops/:id', @auth, 'shops.edit')

    @route('/admin/*', 'error.notFound')

if process.browser
  Router::controllers =
    home: require('./sections/home/home_controller')
    dashboard: require('./sections/dashboard/dashboard_controller')
    error: require('./sections/error/error_controller')
    users: require('./sections/users/users_controller')
    shops: require('./sections/shops/shops_controller')
