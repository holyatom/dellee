AdminController = require('server/base/admin_controller')


class CustomersController extends AdminController
  logPrefix: '[admin customers controller]'
  urlPrefix: '/customers'

  Model: require('server/models/customer')

  roles: ['admin']

  actions: ['list', 'get', 'update', 'delete', 'create']

  listFields: ['_id', 'email', 'email_verified']
  updateFields: ['email_verified']

module.exports = new CustomersController()
