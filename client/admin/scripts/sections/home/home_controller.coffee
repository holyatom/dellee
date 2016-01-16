React = require('react')
Controller = require('admin/base/controller')
HomeView = require('./home_view')
profile = require('admin/modules/profile')


module.exports = class HomeControlller extends Controller
  index: (ctx, done) ->
    data = model: {}
    @renderView(<HomeView onSave={@saveModel} data={data} />, done)

  saveModel: (data) =>
    @view.lockForm()
    @xhrs.save = profile.login(data)
    @xhrs.save.fail (xhr) =>
      @view.showErrorMessage(xhr)
      @view.unlockForm()
