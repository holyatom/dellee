PublicController = require('server/base/public_controller')


class SubscribersController extends PublicController
  logPrefix: '[subscribers controller]'
  urlPrefix: '/subscribers'

  Model: require('server/models/subscriber')

  actions: ['create']

module.exports = new SubscribersController()
