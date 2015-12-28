React = require('react')
Controller = require('app/base/controller')
SubscriptionsView = require('./subscriptions_view')


module.exports = class SubscriptionsControlller extends Controller
  index: (ctx, done) ->
    @renderView(<SubscriptionsView />, done)
