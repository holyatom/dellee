ModelController = require('../base/model_controller')


class SalesController extends ModelController
  logPrefix: '[sales controller]'
  urlPrefix: '/sales'

  adminAuth: true
  adminRoles: ['admin', 'shopadmin', 'moderator']

  Model: require('../models/sale')

  actions: ['create', 'list', 'get']

  listFields: ['_id', 'title', 'start_date', 'end_date']
  joins:
    shop: ['_id', 'name', 'slug']

  get: (req, res, next) ->
    console.log("GET", req.modelItem.shop, req.adminUser.shop)
    if not req.modelItem.shop.equals(req.adminUser.shop)  and req.adminUser.role is 'shopadmin'
      return @notFound(res)

    super

  SalesController::get.url = '/:id'

  create: (req, res, next) ->
    req.body.shop = req.adminUser.shop if req.adminUser.role is 'shopadmin'
    super

  SalesController::create.type = 'post'

  getListOptions: (req) ->
    opts = super
    opts.filters.shop = req.adminUser.shop if req.adminUser.role is 'shopadmin'

    opts

module.exports = new SalesController()
