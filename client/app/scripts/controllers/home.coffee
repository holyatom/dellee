React = require('react')
Controller = require('../base/controller')
HomeView = require('../views/home')


module.exports = class HomeControlller extends Controller
  index: (ctx, done) ->
    @renderView(<HomeView />, done)
