ModelController = require('../base/model_controller')


class UsersController extends ModelController
  logPrefix: '[users controller]'
  urlPrefix: '/users'

  actions: ['create', 'get']

  Model: require('../models/user')

  keyField: 'username'

  # Create user
  create: (req, res, next) ->
    return @notFound(res) if req.authorized

    @Model.findOne(username: req.body.username).exec (err, doc) =>
      return next(err) if err
      return @error(res, 'user_exist', 409) if doc

      req.body.created = new Date()
      super(req, res, next)

  UsersController::create.type = 'post'

module.exports = new UsersController()
