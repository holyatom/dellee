_ = require('lodash')
utils = require('lib/utils')
ModelController = require('../base/model_controller')


class ShopsController extends ModelController
  logPrefix: '[shops controller]'
  urlPrefix: '/shops'

  adminAuth: true
  adminRoles: ['admin']

  Model: require('../models/shop')

  actions: ['create', 'list', 'get']

  listFields: ['_id', 'name', 'slug']

  create: (req, res, next) ->
    req.body.slug = utils.slugify(_.startCase(req.body.name))
    super(req, res, next)

  ShopsController::create.type = 'post'

module.exports = new ShopsController()
