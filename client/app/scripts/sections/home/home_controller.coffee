React = require('react')
Controller = require('app/base/controller')
HomeView = require('./home_view')


module.exports = class HomeControlller extends Controller
  index: (ctx, done) ->
    @renderView(<HomeView onSave={@saveModel} />, done)
