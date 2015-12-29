React = require('react')
CrudController = require('admin/base/crud_controller')


module.exports = class ShopsController extends CrudController
  controllerRoot: '/shops'

  Collection: require('./shops_collection')
  Model: require('./shop_model')

  FormView: require('./shop_form')
  ListView: require('./shops_list')
