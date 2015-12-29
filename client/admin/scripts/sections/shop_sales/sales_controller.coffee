React = require('react')
CrudController = require('admin/base/crud_controller')


module.exports = class SalesController extends CrudController
  controllerRoot: '/shop-sales'

  Collection: require('../sales/sales_collection')
  Model: require('../sales/sale_model')

  FormView: require('./sale_form')
  ListView: require('./sales_list')
