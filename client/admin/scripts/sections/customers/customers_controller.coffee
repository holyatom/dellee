React =require('react')
CrudController = require('admin/base/crud_controller')


module.exports = class CustomersController extends CrudController
  controllerRoot: '/customers'

  Collection: require('./customers_collection')
  ListView: require('./customers_list')
