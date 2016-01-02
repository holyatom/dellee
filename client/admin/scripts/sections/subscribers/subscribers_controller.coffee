React = require('react')
CrudController = require('admin/base/crud_controller')


module.exports = class SubscribersController extends CrudController
  controllerRoot: '/subscribers'

  Collection: require('./subscribers_collection')
  ListView: require('./subscribers_list')
