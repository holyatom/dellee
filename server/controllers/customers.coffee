ModelController = require('../base/model_controller')
Verification = require('../models/verification')


class CustomersController extends ModelController
  logPrefix: '[customers controller]'
  urlPrefix: '/customers'

  Model: require('../models/customer')

  actions: ['create', 'list', 'get', 'delete']

  listFields: ['_id', 'email']

  delete: -> super

  CustomersController::delete.adminRoles = ['admin']
  CustomersController::delete.type = 'delete'
  CustomersController::delete.url = '/:id'

module.exports = new CustomersController()
