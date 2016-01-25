CrudController = require('admin/base/crud_controller')


module.exports = class CompanyApplicationsController extends CrudController
  controllerRoot: '/company-applications'

  Collection: require('./company_applications_collection')
  Model: require('./company_application_model')

  FormView: require('./company_application_form')
  ListView: require('./company_applications_list')
