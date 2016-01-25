_ = require('lodash')
PublicController = require('server/base/public_controller')
Subscription = require('server/models/subscription')


class CompaniesController extends PublicController
  logPrefix: '[companies controller]'
  urlPrefix: '/companies'

  Model: require('server/models/company')

  actions: ['list']
  auth: true

  listFields: ['_id', 'name', 'slug']

  mapList: (req, res, next, data) ->
    filters =
      customer: req.user._id
      company: $in: _.pluck(data.collection, '_id')

    Subscription.find(filters).lean().exec (err, docs) =>
      return next(err) if err

      companiesIds = _.indexBy(docs, 'company')
      item.is_followed = !!companiesIds[item._id] for item in data.collection

      res.json(data)


module.exports = new CompaniesController()
