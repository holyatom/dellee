Q = require('q')
ModelController = require('../base/model_controller')
Verification = require('../models/verification')
sendEmail = require('../tasks/send_email')


class CustomersController extends ModelController
  logPrefix: '[customers controller]'
  urlPrefix: '/customers'

  Model: require('../models/customer')

  actions: ['create', 'list', 'get', 'delete']

  listFields: ['_id', 'email']

  create: (req, res, next) ->
    model = new @Model(req.body)

    model.validate (err) =>
      return @error(res, err.errors) if err

      model.save (err, doc) =>
        return next(err) if err
        req.modelItem = doc

        verification = new Verification(
          customer: doc._id
          type: 'email'
          created: new Date()
        )

        verification.save (err, verificationDoc) =>
          return next(err) if err

          data =
            to: req.modelItem.email
            subject: 'Верификация email адреса'
            template: 'email_verification'
            context:
              verificationId: verificationDoc._id

          sendEmail.task data, (err) =>
            return next(err) if err
            @get(req, res, next)

  CustomersController::create.type = 'post'

  delete: -> super

  CustomersController::delete.adminRoles = ['admin']
  CustomersController::delete.type = 'delete'
  CustomersController::delete.url = '/:id'

module.exports = new CustomersController()
