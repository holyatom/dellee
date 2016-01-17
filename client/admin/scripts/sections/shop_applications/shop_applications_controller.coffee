CrudController = require('admin/base/crud_controller')


module.exports = class ShopApplicationsController extends CrudController
  controllerRoot: '/shop-applications'

  Collection: require('./shop_applications_collection')
  Model: require('./shop_application_model')

  FormView: require('./shop_application_form')
  ListView: require('./shop_applications_list')
