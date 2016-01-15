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

  SHOP_AVAILABEL_STATUES: [
    'new'
    'pending'
  ]

  SHOP_UPDATE_STATUES: [
    'new'
    'rejected'
  ]

  STATUSES_MAP:
    'new': ['pending']
    'pending': ['rejected', 'processed']
    'rejected': ['pending']

  get: (req, res, next) ->
    if not req.modelDoc.shop.equals(req.adminUser.shop)  and req.adminUser.role is 'shopadmin'
      return @notFound(res)

    super

  SalesController::get.url = '/:id'

  create: (req, res, next) ->
    return @error(res, status: 'invalid_sale_status') unless req.body.status in @SHOP_AVAILABEL_STATUES

    req.body.shop = req.adminUser.shop if req.adminUser.role is 'shopadmin'
    super

  SalesController::create.type = 'post'

  update: (req, res, next) ->
    { status } = req.body

    if req.adminUser.role is 'shopadmin'
      return @error(res, 'can_not_update_sale') unless req.modelDoc.status in @SHOP_UPDATE_STATUES
      return @error(res, status: 'invalid_sale_status') if status and status not in @SHOP_AVAILABEL_STATUES

    if status and status isnt req.modelDoc.status
      availableStatuses = @STATUSES_MAP[req.modelDoc.status] or []
      return @error(res, status: 'invalid_sale_status') unless status in availableStatuses

    super

  SalesController::update.type = 'put'
  SalesController::update.url = '/:id'

  getListOptions: (req) ->
    opts = super
    opts.filters.shop = req.adminUser.shop if req.adminUser.role is 'shopadmin'

    opts

  mapDoc: (req, res, next) ->
    @dispatch(req.modelDoc) if req.oldDoc and req.modelDoc.status is 'processed'
    super

  dispatch: (sale) ->
    Customer.find(email_verified: true).lean().exec (err, verifiedCustomers) =>
      return @log("failed to find verified customers") if err
      return unless verifiedCustomers.length

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

module.exports = new SalesController()
