AdminController = require('server/base/admin_controller')


class SubscribersController extends AdminController
  logPrefix: '[subscribers controller]'
  urlPrefix: '/subscribers'

  roles: ['admin']

  DEFAULT_ORDER: '-created'

  Model: require('server/models/subscriber')

  actions: ['list']

  listFields: ['_id', 'email']

module.exports = new SubscribersController()
