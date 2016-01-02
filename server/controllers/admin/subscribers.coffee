AdminController = require('server/base/admin_controller')


class SubscribersController extends AdminController
  logPrefix: '[subscribers controller]'
  urlPrefix: '/subscribers'

  auth: true
  roles: ['admin']

  Model: require('server/models/subscriber')

  actions: ['list']

  listFields: ['_id', 'email']

module.exports = new SubscribersController()
