_ = require('lodash')
async = require('async')
AdminController = require('server/base/admin_controller')
Customer = require('server/models/customer')
Subscription = require('server/models/subscription')
sendEmail = require('server/tasks/send_email')


class SalesController extends AdminController
  logPrefix: '[admin sales controller]'
  urlPrefix: '/sales'

  auth: true
  roles: ['admin', 'shopadmin', 'moderator']

  Model: require('server/models/sale')

  actions: ['create', 'list', 'get', 'update', 'delete']

  listFields: ['_id', 'title', 'start_date', 'end_date', 'status']
  updateFields: ['title', 'start_date', 'end_date', 'message', 'status', 'status_message']
  joins:
    shop: ['_id', 'name', 'slug']

  STATUSES_MAP:
    pending: ['rejected', 'processed']
    rejected: ['pending']

  get: (req, res, next) ->
    if not req.modelItem.shop.equals(req.adminUser.shop)  and req.adminUser.role is 'shopadmin'
      return @notFound(res)

    super

  SalesController::get.url = '/:id'

  create: (req, res, next) ->
    req.body.status = 'pending'
    req.body.shop = req.adminUser.shop if req.adminUser.role is 'shopadmin'
    super

  SalesController::create.type = 'post'

  update: (req, res, next) ->
    { status } = req.body

    if req.adminUser.role is 'shopadmin' and status
      return @error(res, status: 'invalid_sale_status') if status isnt 'pending'

    if status
      availableStatuses = @STATUSES_MAP[req.modelItem.status] or []
      return @error(res, status: 'invalid_sale_status') unless status in availableStatuses

    fields = @getUpdateFields(req)
    req.modelItem.set(fields)

    req.modelItem.validate (err) =>
      return @error(res, err.errors) if err

      req.modelItem.save (err) =>
        return next(err) if err

        @send(req.modelItem) if status is 'processed'
        @get(req, res, next)

  SalesController::update.type = 'put'
  SalesController::update.url = '/:id'

  send: (sale) ->
    Customer.find(email_verified: true).lean().exec (err, verifiedCustomers) =>
      if err
        return @log("failed to find verified customers")

      query = Subscription
        .find(shop: sale.shop, customer: $in: _.pluck(verifiedCustomers, '_id'))
        .populate('customer')
        .lean()

      query.exec (err, collection) =>
        if err
          return @log("failed to add task to send \"Sale #{sale._id}: #{sale.title}\"", 'red bold')

        tasks = []

        for subscription in collection
          tasks.push(@createSendEmailTask(sale, subscription.customer))

        async.parallel(tasks)

  createSendEmailTask: (sale, customer) ->
    ->
      sendEmail.task(
        to: customer.email
        subject: sale.title
        template: 'sale'
        context:
          message: sale.message
      )

  getListOptions: (req) ->
    opts = super
    opts.filters.shop = req.adminUser.shop if req.adminUser.role is 'shopadmin'

    opts

module.exports = new SalesController()
