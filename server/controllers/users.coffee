ModelController = require('../base/model_controller')


class UsersController extends ModelController
  logPrefix: '[users controller]'
  urlPrefix: '/users'

  adminAuth: true

  Model: require('../models/user')

  actions: ['create', 'list', 'get']

  listFields: ['_id', 'username', 'role', 'created']
  joins:
    shop: ['_id', 'name', 'slug']

  getModelItem: (req, res, next) ->
    req.params.id = req.adminUser._id if req.params.id is 'profile'
    super

  # Create user
  create: (req, res, next) ->
    return @notFound(res) if req.authorized

    @Model.findOne(username: req.body.username).exec (err, doc) =>
      return next(err) if err
      return @error(res, 'user_exist', 409) if doc

      isShopAdmin = req.body.role is 'shopadmin'

      if isShopAdmin and not req.body.shop?
        return @error(res, shop: 'required')

      delete req.body.shop unless isShopAdmin
      req.body.created = new Date()

      super(req, res, next)

  UsersController::create.type = 'post'
  UsersController::create.adminRoles = ['admin']

  list: -> super

  UsersController::list.adminRoles = ['admin']

module.exports = new UsersController()
