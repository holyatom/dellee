React =require('react')
CrudController = require('admin/base/crud_controller')


module.exports = class SalesController extends CrudController
  controllerRoot: '/sales'

  Collection: require('./sales_collection')
  Model: require('./sale_model')

  FormView: require('./sale_form')
  ListView: require('./sales_list')
