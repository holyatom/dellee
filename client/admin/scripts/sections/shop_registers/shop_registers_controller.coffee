CrudController = require('admin/base/crud_controller')


module.exports = class ShopRegistersController extends CrudController
  controllerRoot: '/shop-registers'

  Collection: require('./shop_registers_collection')
  Model: require('../shop_register/shop_register_model')

  FormView: require('./shop_register_form')
  ListView: require('./shop_registers_list')
