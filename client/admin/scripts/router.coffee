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
    @route('/admin/register-company', @notAuth, 'register_company.create')

    @route('/admin/dashboard', @auth, 'dashboard.index')

    # Admin
    @route('/admin/users', @requireRole('admin'), 'users.index')
    @route('/admin/users/create', @requireRole('admin'), 'users.create')
    @route('/admin/users/:id', @requireRole('admin'), 'users.edit')

    @route('/admin/companies', @requireRole('admin'), 'companies.index')
    @route('/admin/companies/create', @requireRole('admin'), 'companies.create')
    @route('/admin/companies/:id', @requireRole('company_user'), 'companies.edit')

    @route('/admin/customers', @requireRole('admin'), 'customers.index')
    @route('/admin/customers/create', @requireRole('admin'), 'customers.create')
    @route('/admin/customers/:id', @requireRole('admin'), 'customers.edit')

    @route('/admin/subscribers', @requireRole('admin'), 'subscribers.index')

    # Moderator
    @route('/admin/sales', @requireRole('moderator'), 'sales.index')
    @route('/admin/sales/create', @requireRole('moderator'), 'sales.create')
    @route('/admin/sales/:id', @requireRole('moderator'), 'sales.edit')

    @route('/admin/company-applications', @requireRole('moderator'), 'company_applications.index')
    @route('/admin/company-applications/:id', @requireRole('moderator'), 'company_applications.edit')

    # company admin
    @route('/admin/company-sales', @requireRole('company_user', strict: true), 'company_sales.index')
    @route('/admin/company-sales/create', @requireRole('company_user', strict: true), 'company_sales.create')
    @route('/admin/company-sales/:id', @requireRole('company_user', strict: true), 'company_sales.edit')

    @route('/admin/*', 'error.notFound')

if process.browser
  Router::controllers =
    home: require('./sections/home/home_controller')
    dashboard: require('./sections/dashboard/dashboard_controller')
    error: require('./sections/error/error_controller')
    users: require('./sections/users/users_controller')
    companies: require('./sections/companies/companies_controller')
    company_sales: require('./sections/company_sales/company_sales_controller')
    sales: require('./sections/sales/sales_controller')
    customers: require('./sections/customers/customers_controller')
    subscribers: require('./sections/subscribers/subscribers_controller')
    register_company: require('./sections/register_company/register_company_controller')
    company_applications: require('./sections/company_applications/company_applications_controller')
