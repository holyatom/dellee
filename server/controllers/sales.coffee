_ = require('lodash')
async = require('async')
ModelController = require('../base/model_controller')
Customer = require('../models/customer')
sendEmail = require('../tasks/send_email')


class SalesController extends ModelController
  logPrefix: '[sales controller]'
  urlPrefix: '/sales'

  adminAuth: true
  adminRoles: ['admin', 'shopadmin', 'moderator']

  Model: require('../models/sale')

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
    query = Customer
      .find({})
      .select('email')
      .lean()

    query.exec (err, collection) =>
      if err
        return @log("failed to add task to send \"Sale #{sale._id}: #{sale.title}\"", 'red bold')

      tasks = []

      for customer in collection
        ((email)->
          tasks.push ->
            sendEmail.task(
              to: email
              subject: sale.title
              template: 'sale'
              context:
                message: sale.message
            )
        )(customer.email)

      async.parallel(tasks)

  getListOptions: (req) ->
    opts = super
    opts.filters.shop = req.adminUser.shop if req.adminUser.role is 'shopadmin'

    opts

module.exports = new SalesController()
