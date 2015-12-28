React = require('react')
Controller = require('app/base/controller')
profile = require('app/modules/profile')
LoginView = require('./login_view')


module.exports = class LoginControlller extends Controller
  index: (ctx, done) ->
    @renderView(<LoginView onSave={@saveModel} />, done)

  saveModel: (model) =>
    profile.login(model)
