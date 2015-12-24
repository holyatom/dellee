ModelController = require('../base/model_controller')
jwt = require('jsonwebtoken')
config = require('config')


class AdminAuthController extends ModelController
  logPrefix: '[admin auth controller]'
  urlPrefix: '/admin-auth'

  actions: ['login']

  Model: require('../models/user')

  generateToken: (user) ->
    expires = new Date();
    claims =
      sub: user.username
      iss: 'https://dellee.me'
      role: user.role

    token = jwt.sign(claims, config.admin.jwt.secret,
      expiresInMinutes: config.admin.jwt.expires
    )

    expires.setMinutes(expires.getMinutes() + config.admin.jwt.expires);

    # return
    expires: expires
    value: token

  login: (req, res, next) ->
    { username, password } = req.body

    return @error(res, username: 'wrong_login_or_password') if not username or not password

    @Model.findOne({ username }).exec (err, doc) =>
      return next(err) if err
      return @error(res, 'unknown_user', 404) unless doc

      if doc and doc.comparePassword(password)
        user = doc.toJSON()
        user.token = @generateToken(user)
        res.json(user)
      else
        @error(res, username: 'wrong_login_or_password')

  AdminAuthController::login.type = 'post'

module.exports = new AdminAuthController()
