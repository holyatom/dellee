utils = require('lib/utils')
Q = require('q')
AdminController = require('server/base/admin_controller')
User = require('server/models/user')
Sale = require('server/models/sale')
File =require('server/models/file')


class ShopsController extends AdminController
  logPrefix: '[admin shops controller]'
  urlPrefix: '/shops'

  auth: true
  roles: ['admin']

  Model: require('server/models/shop')

  actions: ['create', 'list', 'get', 'delete', 'update']

  listFields: ['_id', 'name', 'slug']
  updateFields: ['name', 'slug', 'logo_url']

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
    Q.all([
      User.remove(shop: req.modelItem._id)
      Sale.remove(shop: req.modelItem._id)
    ])
    .then =>
      super(req, res, next)
    .fail (err) ->
      next(err)

  ShopsController::delete.type = 'delete'
  ShopsController::delete.url = '/:id'

  mapDoc: (req, res, next) ->
    item = req.modelItem.toJSON()

    File.findOne(url: item.logo_url).exec (err, fileDoc) ->
      return next(err) if err

      item.logo = fileDoc.toJSON() if fileDoc
      res.json(item)

module.exports = new ShopsController()
