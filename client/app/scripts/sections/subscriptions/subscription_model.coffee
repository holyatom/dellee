Model = require('app/base/model')


module.exports = class SubscriptionModel extends Model
  resourceUrl: -> "/companies/#{@companyId}/followers"

  isNew: -> false
  sync: (method, model, options) ->
    options.method = 'POST' unless method is 'delete'
    super
