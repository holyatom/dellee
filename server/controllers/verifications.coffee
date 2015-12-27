ModelController = require('../base/model_controller')
Customer = require('../models/customer')


class VerificationsController extends ModelController
  logPrefix: '[verification controller]'
  urlPrefix: '/verifications'

  Model: require('../models/verification')

  actions: ['get']

  get: (req, res, next) ->
    Customer.findOne _id: req.modelItem.customer, (err, customer) =>
      return next(err) if err
      return @notFound(res) unless customer

      if req.modelItem.type is 'email'
        customer.email_verified = true

      customer.save (err) =>
        return next(err) if err
        @delete(req, res, next)

  VerificationsController::get.url = '/:id'

module.exports = new VerificationsController()
