React = require('react')
Controller = require('admin/base/controller')
DashboardView = require('./dashboard_view')


module.exports = class DashboardControlller extends Controller
  index: (ctx, done) ->
    @renderView(<DashboardView />, done)
