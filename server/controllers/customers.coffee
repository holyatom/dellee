ModelController = require('../base/model_controller')


class CustomersController extends ModelController
  logPrefix: '[customers controller]'
  urlPrefix: '/customers'

  Model: require('../models/customer')

  actions: ['create', 'list']

  listFields: ['email']

module.exports = new CustomersController()
