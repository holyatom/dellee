PublicController = require('server/base/public_controller')
Customer = require('server/models/customer')


class VerificationsController extends PublicController
  logPrefix: '[verification controller]'
  urlPrefix: '/verifications'

  Model: require('server/models/verification')

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
