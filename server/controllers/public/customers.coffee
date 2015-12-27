ModelController = require('server/base/model_controller')
Verification = require('server/models/verification')
sendEmail = require('server/tasks/send_email')


class CustomersController extends ModelController
  logPrefix: '[customers controller]'
  urlPrefix: '/customers'

  Model: require('server/models/customer')

  actions: ['create']

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
            res.json(sucess: true)

  CustomersController::create.type = 'post'

module.exports = new CustomersController()
