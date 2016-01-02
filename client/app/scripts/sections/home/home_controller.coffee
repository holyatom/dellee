React = require('react')
Controller = require('app/base/controller')
HomeView = require('./home_view')
SubscriberModel = require('./subscriber_model')


module.exports = class HomeControlller extends Controller
  index: (ctx, done) ->
    @renderView(<HomeView onSave={@saveModel} />, done)

  saveModel: (data) =>
    model = new SubscriberModel(data)
    @xhrs.save = model.save()

    @view.lockForm()

    @xhrs.save.then =>
      @view.setState(success: true)
    .fail (xhr) =>
      message = 'Ошибка сервера'

      if error = xhr.responseJSON?.error
        if fields = error.fields
          message = fields.email.message
          message = 'E-mail адрес уже был зарегестрирован' if fields.email.code is 'unique'
        else
          message = error.message

      @view.setState(error: message)
    .always =>
      @view.unlockForm()
