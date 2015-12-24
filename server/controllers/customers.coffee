ModelController = require('../base/model_controller')


class CustomersController extends ModelController
  logPrefix: '[customers controller]'
  urlPrefix: '/customers'

  Model: require('../models/customer')

  actions: ['create']

module.exports = new CustomersController()
