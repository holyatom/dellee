React = require('react')
Controller = require('../base/controller')
DashboardView = require('../views/dashboard')


module.exports = class DashboardControlller extends Controller
  index: (ctx, done) ->
    @renderView(<DashboardView />, done)
