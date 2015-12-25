ModelController = require('../base/model_controller')


class UsersController extends ModelController
  logPrefix: '[users controller]'
  urlPrefix: '/users'

  adminAuth: true
  adminRoles: ['admin']

  Model: require('../models/user')

  actions: ['create', 'list', 'get']

  listFields: ['_id', 'username', 'role', 'created']
  joins:
    shop: ['_id', 'name', 'slug']

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

module.exports = new UsersController()
