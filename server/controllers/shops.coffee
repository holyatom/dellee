utils = require('lib/utils')
ModelController = require('../base/model_controller')
User = require('../models/user')


class ShopsController extends ModelController
  logPrefix: '[shops controller]'
  urlPrefix: '/shops'

  adminAuth: true
  adminRoles: ['admin']

  Model: require('../models/shop')

  actions: ['create', 'list', 'get', 'delete', 'update']

  listFields: ['_id', 'name', 'slug']
  updateFields: ['name', 'slug']

  create: (req, res, next) ->
    req.body.slug = utils.slugify(req.body.name)
    super(req, res, next)

  ShopsController::create.type = 'post'

  update: (req, res, next) ->
    req.body.slug = utils.slugify(req.body.name)
    super(req, res, next)

  ShopsController::update.type = 'put'
  ShopsController::update.url = '/:id'

  delete: (req, res, next) ->
    User.remove shop: req.modelItem._id, (err) =>
      return next(err) if err
      super(req, res, next)

  ShopsController::delete.type = 'delete'
  ShopsController::delete.url = '/:id'

module.exports = new ShopsController()
