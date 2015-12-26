React =require('react')
CrudController = require('admin/base/crud_controller')
ShopsCollection = require('../shops/shops_collection')


module.exports = class UsersController extends CrudController
  controllerRoot: '/users'

  Collection: require('./users_collection')
  Model: require('./user_model')

  FormView: require('./user_form')
  ListView: require('./users_list')

  extraData: (method) ->
    if method in ['edit', 'create']
      shops: @shopsCollection.toJSON()
    else
      super

  fetchExtraData: (method) ->
    if method in ['edit', 'create']
      @shopsCollection = new ShopsCollection()
      @xhrs.shops = @shopsCollection.fetch()
    else
      super
