React =require('react')
CrudController = require('admin/base/crud_controller')


module.exports = class CustomersController extends CrudController
  controllerRoot: '/customers'

  Collection: require('./customers_collection')
  Model: require('./customer_model')

  FormView: require('./customer_form')
  ListView: require('./customers_list')
