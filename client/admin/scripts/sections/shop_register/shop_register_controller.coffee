CrudController = require('admin/base/crud_controller')
vent = require('admin/modules/vent')


module.exports = class ShopRegisterController extends CrudController
  controllerRoot: '/shop-register'

  Model: require('./shop_register_model')
  FormView: require('./shop_register_form')

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
