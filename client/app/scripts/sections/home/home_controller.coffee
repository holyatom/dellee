React = require('react')
Controller = require('app/base/controller')
HomeView = require('./home_view')
UserModel = require('./user_model')


module.exports = class HomeControlller extends Controller
  index: (ctx, done) ->
    @renderView(<HomeView onSave={@saveModel} />, done)

  saveModel: (model) =>
    user = new UserModel(model)
    @xhrs.save = user.save().then =>
      @view.setState(model: {})
