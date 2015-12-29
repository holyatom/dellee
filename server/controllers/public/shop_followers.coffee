PublicController = require('server/base/public_controller')
Customer = require('server/models/customer')
Shop = require('server/models/shop')


class ShopFollowersController extends PublicController
  logPrefix: '[shop followers controller]'
  urlPrefix: '/shops/:shop_id/followers'

  Model: require('server/models/subscription')

  actions: ['create', 'delete']
  auth: true

  mapDoc: (req, res, next, doc) ->
    res.json(success: true)

  create: (req, res, next) ->
    Shop.findOne(_id: req.params.shop_id).exec (err, shopDoc) =>
      return next(err) if err
      return @notFound(res) unless shopDoc

      req.body =
        customer: req.user._id
        shop: shopDoc._id

      @Model.findOne(req.body).exec (err, doc) =>
        return next(err) if err
        return @error(res, shop_id: 'alwready_following') if doc

        super(req, res, next)

  ShopFollowersController::create.type = 'post'

  delete: (req, res, next) ->
    Shop.findOne(_id: req.params.shop_id).exec (err, shopDoc) =>
      return next(err) if err
      return @notFound(res) unless shopDoc

      model =
        customer: req.user._id
        shop: shopDoc._id

      @Model.findOne(model).exec (err, doc) =>
        return next(err) if err
        return @error(res, shop_id: 'not_following') unless doc

        req.modelItem = doc
        super(req, res, next)

  ShopFollowersController::delete.type = 'delete'

module.exports = new ShopFollowersController()
