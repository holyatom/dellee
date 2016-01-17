CrudController = require('admin/base/crud_controller')
vent = require('admin/modules/vent')


module.exports = class ApplyAccountController extends CrudController
  controllerRoot: '/apply-account'

  Model: require('../shop_applications/shop_application_model')
  FormView: require('./apply_account_form')

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
