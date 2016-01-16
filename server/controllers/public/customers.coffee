PublicController = require('server/base/public_controller')
Verification = require('server/models/verification')
sendEmail = require('server/tasks/send_email')


class CustomersController extends PublicController
  logPrefix: '[customers controller]'
  urlPrefix: '/customers'

  Model: require('server/models/customer')

  actions: ['create', 'get']

  get: (req, res, next) ->
    res.json(req.user)

  CustomersController::get.url = '/profile'
  CustomersController::get.auth = true

  mapDoc: (req, res, next) ->
    if not req.oldDoc and req.method is 'POST'
      verification = new Verification(
        customer: req.modelDoc._id
        type: 'email'
      )

      verification.save (err, doc) =>
        return @log(err, 'red bold') if err

        data =
          to: req.modelDoc.email
          template: 'email_verification'
          context:
            verificationId: doc._id
            email: req.modelDoc.email

        sendEmail.task data, (err) => @log(err, 'red bold') if err

    super

  CustomersController::create.type = 'post'

module.exports = new CustomersController()
