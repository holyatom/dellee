BaseRouter = require('./base/router')
# profile = require('./modules/profile')
vent = require('./modules/vent')


module.exports = class Router extends BaseRouter
  # run: ->
  #   super

  #   vent.on('user:login', => @routeTo('/subscriptions'))
  #   vent.on('user:logout', => @routeTo('/'))

  # auth: (ctx, next) =>
  #   return @page.redirect('/login') unless profile.authorized()
  #   next()

  # notAuth: (ctx, next) =>
  #   return @page.redirect('/subscriptions') if profile.authorized()
  #   next()

  router: ->
    @route('/', 'home.index')
    @route('/about', 'content.about')
    @route('/terms', 'content.terms')
    @route('/privacy', 'content.privacy')
    @route('/contacts', 'content.contacts')

    # @route('/login', @notAuth, 'login.index')
    # @route('/subscriptions', @auth, 'subscriptions.index')
    # @route('/verify/:id', 'verify.index')

    @route('*', 'error.notFound')

if process.browser
  Router::controllers =
    error: require('./sections/error/error_controller')
    home: require('./sections/home/home_controller')
    content: require('./sections/content/content_controller')


    # verify: require('./sections/verify/verify_controller')
    # login: require('./sections/login/login_controller')
    # subscriptions: require('./sections/subscriptions/subscriptions_controller')
