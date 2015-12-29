_ = require('lodash')
PublicController = require('server/base/public_controller')
Subscription = require('server/models/subscription')


class ShopsController extends PublicController
  logPrefix: '[shops controller]'
  urlPrefix: '/shops'

  Model: require('server/models/shop')

  actions: ['list']
  auth: true

  listFields: ['_id', 'name', 'slug']

  mapList: (req, res, next, data) ->
    filters =
      customer: req.user._id
      shop: $in: _.pluck(data.collection, '_id')

    Subscription.find(filters).lean().exec (err, docs) =>
      return next(err) if err

      shopsIds = _.indexBy(docs, 'shop')
      item.is_followed = !!shopsIds[item._id] for item in data.collection

      res.json(data)


module.exports = new ShopsController()
