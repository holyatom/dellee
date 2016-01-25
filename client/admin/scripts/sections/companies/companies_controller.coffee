React = require('react')
CrudController = require('admin/base/crud_controller')


module.exports = class CompaniesController extends CrudController
  controllerRoot: '/companies'

  Collection: require('./companies_collection')
  Model: require('./company_model')

  FormView: require('./company_form')
  ListView: require('./companies_list')
