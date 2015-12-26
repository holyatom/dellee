ModelController = require('../base/model_controller')


class UsersController extends ModelController
  logPrefix: '[users controller]'
  urlPrefix: '/users'

  adminAuth: true

  Model: require('../models/user')

  actions: ['create', 'list', 'get', 'delete', 'update']

  listFields: ['_id', 'username', 'role', 'created']
  updateFields: ['username', 'role', 'shop']
  joins:
    shop: ['_id', 'name', 'slug']

  create: (req, res, next) ->
    @Model.findOne(username: req.body.username).exec (err, doc) =>
      return next(err) if err
      return @error(res, 'user_exist', 409) if doc

      if req.body.role is 'shopadmin'
        return @error(res, shop: 'required') unless req.body.shop?
      else
        delete req.body.shop

      req.body.created = new Date()
      super(req, res, next)

  UsersController::create.type = 'post'
  UsersController::create.adminRoles = ['admin']

  update: (req, res, next) ->
    if req.body.role is 'shopadmin'
      return @error(res, shop: 'required') unless req.body.shop?
    else
      delete req.body.shop
      req.modelItem.shop = null

    super(req, res, next)

  UsersController::update.type = 'put'
  UsersController::update.url = '/:id'
  UsersController::update.adminRoles = ['admin']

  list: -> super

  UsersController::list.adminRoles = ['admin']

  delete: -> super

  UsersController::delete.adminRoles = ['admin']
  UsersController::delete.type = 'delete'
  UsersController::delete.url = '/:id'

  getModelItem: (req, res, next) ->
    req.params.id = req.adminUser._id if req.params.id is 'profile'
    super(req, res, next)

module.exports = new UsersController()
