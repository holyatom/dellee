React =require('react')
CrudController = require('../base/crud_controller')


module.exports = class ShopsController extends CrudController
  controllerRoot: '/shops'

  Collection: require('../models/shops')
  Model: require('../models/shop')

  FormView: require('../views/shop')
  ListView: require('../views/shops')
