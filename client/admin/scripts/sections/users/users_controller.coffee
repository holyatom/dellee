React = require('react')
CrudController = require('admin/base/crud_controller')
CompaniesCollection = require('../companies/companies_collection')


module.exports = class UsersController extends CrudController
  controllerRoot: '/users'

  Collection: require('./users_collection')
  Model: require('./user_model')

  FormView: require('./user_form')
  ListView: require('./users_list')

  extraData: (method) ->
    if method in ['edit', 'create']
      companies: @companies.toJSON()
    else
      super

  fetchExtraData: (method) ->
    if method in ['edit', 'create']
      @companies = new CompaniesCollection()
      @xhrs.companies = @companies.fetch()
    else
      super
