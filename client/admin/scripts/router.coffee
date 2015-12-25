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

  middleware: ->
    @use('/admin', @notAuth)
    @use('/admin/dashboard', @auth)

    @use('/admin/users', @auth)
    @use('/admin/users/create', @auth)
    @use('/admin/users/:id', @auth)

  router: ->
    @route('/admin', 'home.index')
    @route('/admin/dashboard', 'dashboard.index')

    @route('/admin/users', 'users.index')
    @route('/admin/users/create', 'users.create')
    @route('/admin/users/:id', 'users.edit')

    @route('/admin/*', 'notFound.index')

if process.browser
  Router::controllers =
    home: require('./controllers/home')
    dashboard: require('./controllers/dashboard')
    notFound: require('./controllers/not_found')
    users: require('./controllers/users')
