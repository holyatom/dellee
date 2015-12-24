React = require('react')
Controller = require('../base/controller')
NotFoundView = require('../views/not_found')


module.exports = class NotFoundConntroller extends Controller
  index: (ctx, done) ->
    @renderView(<NotFoundView />, done)
