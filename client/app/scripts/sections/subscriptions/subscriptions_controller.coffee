React = require('react')
Controller = require('app/base/controller')
SubscriptionsView = require('./subscriptions_view')
ShopsCollection = require('./shops_collection')


module.exports = class SubscriptionsControlller extends Controller
  index: (ctx, done) ->
    shopsCollection = new ShopsCollection()
    @xhrs.shops = shopsCollection.fetch()

    @xhrs.shops.then =>
      data =
        shops: shopsCollection.toJSON()

      @renderView(<SubscriptionsView data={data} />, done)

    .fail (xhr) =>
      @renderErrorView(xhr, done)
