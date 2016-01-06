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

  requireRole: (role, opts) ->
    (ctx, next) =>
      unless profile.is(role, opts)
        @page.redirect('/admin/dashboard')
      else
        next()

  adminRoute: (url, action) ->
    @route(url, @auth, @requireRole('admin'), action)

  shopAdminRoute: (url, action) ->
    @route(url, @auth, @requireRole('shopadmin', strict: true), action)

  moderatorRoute: (url, action) ->
    @route(url, @auth, @requireRole('moderator'), action)

  router: ->
    @route('/admin', @notAuth, 'home.index')
    @route('/admin/dashboard', @auth, 'dashboard.index')

    @adminRoute('/admin/users', 'users.index')
    @adminRoute('/admin/users/create', 'users.create')
    @adminRoute('/admin/users/:id', 'users.edit')

    @adminRoute('/admin/shops', 'shops.index')
    @adminRoute('/admin/shops/create', 'shops.create')
    @adminRoute('/admin/shops/:id', 'shops.edit')

    @adminRoute('/admin/customers', 'customers.index')
    @adminRoute('/admin/customers/create', 'customers.create')
    @adminRoute('/admin/customers/:id', 'customers.edit')

    @adminRoute('/admin/subscribers', 'subscribers.index')

    @moderatorRoute('/admin/sales', 'sales.index')
    @moderatorRoute('/admin/sales/create', 'sales.create')
    @moderatorRoute('/admin/sales/:id', 'sales.edit')

    @shopAdminRoute('/admin/shop-sales', 'shop_sales.index')
    @shopAdminRoute('/admin/shop-sales/create', 'shop_sales.create')
    @shopAdminRoute('/admin/shop-sales/:id', 'shop_sales.edit')

    @route('/admin/*', 'error.notFound')

if process.browser
  Router::controllers =
    home: require('./sections/home/home_controller')
    dashboard: require('./sections/dashboard/dashboard_controller')
    error: require('./sections/error/error_controller')
    users: require('./sections/users/users_controller')
    shops: require('./sections/shops/shops_controller')
    shop_sales: require('./sections/shop_sales/sales_controller')
    sales: require('./sections/sales/sales_controller')
    customers: require('./sections/customers/customers_controller')
    subscribers: require('./sections/subscribers/subscribers_controller')
