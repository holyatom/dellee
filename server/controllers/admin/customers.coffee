AdminController = require('server/base/admin_controller')


class CustomersController extends AdminController
  logPrefix: '[admin customers controller]'
  urlPrefix: '/customers'

  Model: require('server/models/customer')

  auth: true
  roles: ['admin']

  actions: ['list', 'get', 'delete']

  listFields: ['_id', 'email']

module.exports = new CustomersController()
