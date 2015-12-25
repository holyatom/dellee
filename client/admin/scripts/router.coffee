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

  requireRole: (role) ->
    (ctx, next) =>
      unless profile.is(role)
        @page.redirect('/admin/dashboard')
      else
        next()

  adminRoute: (url, action) ->
    @route(url, @auth, @requireRole('admin'), action)

  router: ->
    @route('/admin', @notAuth, 'home.index')
    @route('/admin/dashboard', @auth, 'dashboard.index')

    @adminRoute('/admin/users', 'users.index')
    @adminRoute('/admin/users/create', 'users.create')
    @adminRoute('/admin/users/:id', 'users.edit')

    @adminRoute('/admin/shops', 'shops.index')
    @adminRoute('/admin/shops/create', 'shops.create')
    @adminRoute('/admin/shops/:id', 'shops.edit')

    @route('/admin/*', 'error.notFound')

if process.browser
  Router::controllers =
    home: require('./sections/home/home_controller')
    dashboard: require('./sections/dashboard/dashboard_controller')
    error: require('./sections/error/error_controller')
    users: require('./sections/users/users_controller')
    shops: require('./sections/shops/shops_controller')
