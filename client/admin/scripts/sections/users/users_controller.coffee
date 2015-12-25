React =require('react')
CrudController = require('admin/base/crud_controller')


module.exports = class UsersController extends CrudController
  controllerRoot: '/users'

  Collection: require('./users_collection')
  Model: require('./user_model')

  FormView: require('./user_form')
  ListView: require('./users_list')
