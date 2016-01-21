CrudController = require('admin/base/crud_controller')
vent = require('admin/modules/vent')


module.exports = class RegisterCompanyController extends CrudController
  controllerRoot: '/register-company'

  Model: require('../shop_applications/shop_application_model')
  FormView: require('./register_company_form')

  saveModel: (data) =>
    model = new @Model(data)

    @view.lockForm()
    @xhrs.save = model.save()
    @xhrs.save.then =>
      vent.trigger('scroll', animate: false)
      @view.showSuccessMessage()
    .fail (xhr) =>
      @view.showErrorMessage(xhr)
      @view.unlockForm()
