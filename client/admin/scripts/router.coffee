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

  router: ->
    @route('/admin', @notAuth, 'home.index')
    @route('/admin/dashboard', @auth, 'dashboard.index')

    @route('/admin/users', @requireRole('admin'), 'users.index')
    @route('/admin/users/create', @requireRole('admin'), 'users.create')
    @route('/admin/users/:id', @requireRole('admin'), 'users.edit')

    @route('/admin/shops', @requireRole('admin'), 'shops.index')
    @route('/admin/shops/create', @requireRole('admin'), 'shops.create')
    @route('/admin/shops/:id', @requireRole('shopadmin'), 'shops.edit')

    @route('/admin/customers', @requireRole('admin'), 'customers.index')
    @route('/admin/customers/create', @requireRole('admin'), 'customers.create')
    @route('/admin/customers/:id', @requireRole('admin'), 'customers.edit')

    @route('/admin/subscribers', @requireRole('admin'), 'subscribers.index')

    @route('/admin/sales', @requireRole('moderator'), 'sales.index')
    @route('/admin/sales/create', @requireRole('moderator'), 'sales.create')
    @route('/admin/sales/:id', @requireRole('moderator'), 'sales.edit')

    @route('/admin/shop-sales', @requireRole('shopadmin', strict: true), 'shop_sales.index')
    @route('/admin/shop-sales/create', @requireRole('shopadmin', strict: true), 'shop_sales.create')
    @route('/admin/shop-sales/:id', @requireRole('shopadmin', strict: true), 'shop_sales.edit')

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
