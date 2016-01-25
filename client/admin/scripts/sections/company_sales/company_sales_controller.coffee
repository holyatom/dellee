React = require('react')
CrudController = require('admin/base/crud_controller')


module.exports = class SalesController extends CrudController
  controllerRoot: '/company-sales'

  Collection: require('../sales/sales_collection')
  Model: require('../sales/sale_model')

  FormView: require('./company_sale_form')
  ListView: require('./company_sales_list')
