Model = require('app/base/model')


module.exports = class SubscriptionModel extends Model
  resourceUrl: -> "/shops/#{@shopId}/followers"

  isNew: -> false
  sync: (method, model, options) ->
    options.method = 'POST' unless method is 'delete'
    super
