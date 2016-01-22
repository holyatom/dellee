React = require('react')
Controller = require('app/base/controller')
HomeView = require('./home_view')
SubscriberModel = require('./subscriber_model')
vent = require('app/modules/vent')


module.exports = class HomeControlller extends Controller
  index: (ctx, done) ->
    @renderView(<HomeView onSave={@saveModel} onShare={@share} />, done)

  share: (type) =>
    vent.trigger("share:#{type}")

  saveModel: (data) =>
    model = new SubscriberModel(data)
    @xhrs.save = model.save()

    @view.lockForm()

    @xhrs.save.then =>
      vent.trigger('analytics:event', category: 'form', action: 'early_access')
      @view.setState(success: true, error: false)
    .fail (xhr) =>
      message = 'Ошибка сервера'

      if error = xhr.responseJSON?.error
        if fields = error.fields
          message = fields.email.message
          message = 'E-mail адрес уже был зарегестрирован' if fields.email.code is 'unique'
          message = 'Введите e-mail' if fields.email.code is 'required'
        else
          message = error.message

      @view.setState(error: message)
    .always =>
      @view.unlockForm()
