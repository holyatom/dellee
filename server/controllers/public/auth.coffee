PublicController = require('server/base/public_controller')
jwt = require('jsonwebtoken')
config = require('config')


class AuthController extends PublicController
  logPrefix: '[auth controller]'
  urlPrefix: '/auth'

  actions: ['login']

  Model: require('server/models/customer')

  generateToken: (customer) ->
    expires = new Date()
    claims =
      sub: customer._id
      iss: 'https://dellee.me'

    token = jwt.sign(claims, config.public.jwt.secret,
      expiresIn: config.public.jwt.expires
    )

    expires.setSeconds(expires.getSeconds() + config.public.jwt.expires);

    # return
    expires: expires
    value: token

  login: (req, res, next) ->
    return @notFound(res) if req.authorized

    { email, password } = req.body

    return @error(res, email: 'wrong_login_or_password') if not email or not password

    @Model.findOne({ email }).exec (err, doc) =>
      return next(err) if err
      return @error(res, 'unknown_user', 404) unless doc

      if doc and doc.comparePassword(password)
        customer = doc.toJSON()
        res.json(token: @generateToken(customer))
      else
        @error(res, email: 'wrong_login_or_password')

  AuthController::login.type = 'post'

module.exports = new AuthController()
