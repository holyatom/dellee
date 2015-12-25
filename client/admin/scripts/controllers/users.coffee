React =require('react')
CrudController = require('../base/crud_controller')


module.exports = class UsersController extends CrudController
  controllerRoot: '/users'

  Collection: require('../models/users')
  Model: require('../models/user')

  FormView: require('../views/user')
  ListView: require('../views/users')
