React = require('react')
Controller = require('admin/base/controller')
NotFoundView = require('./not_found_view')


module.exports = class NotFoundConntroller extends Controller
  notFound: (ctx, done) ->
    @renderView(<NotFoundView />, done)
