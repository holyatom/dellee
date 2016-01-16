AdminController = require('server/base/admin_controller')
jwt = require('jsonwebtoken')
config = require('config')


class AdminAuthController extends AdminController
  logPrefix: '[admin auth controller]'
  urlPrefix: '/auth'

  actions: ['login']

  Model: require('server/models/user')

  generateToken: (user) ->
    expires = new Date()
    claims =
      sub: user._id
      iss: 'https://dellee.me'
      role: user.role

    token = jwt.sign(claims, config.admin.jwt.secret,
      expiresIn: config.admin.jwt.expires
    )

    expires.setSeconds(expires.getSeconds() + config.admin.jwt.expires);

    # return
    expires: expires
    value: token

  login: (req, res, next) ->
    return @notFound(res) if req.adminAuthorized

    { username, password } = req.body

    return @error(res, username: 'wrong_login_or_password') if not username or not password

    @Model.findOne({ username }).exec (err, doc) =>
      return next(err) if err
      return @error(res, 'unknown_user', 404) unless doc

      if doc and doc.comparePassword(password)
        user = doc.toJSON()
        res.json(token: @generateToken(user))
      else
        @error(res, username: 'wrong_login_or_password')

  AdminAuthController::login.type = 'post'

module.exports = new AdminAuthController()
