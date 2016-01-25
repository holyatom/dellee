PublicController = require('server/base/public_controller')
Customer = require('server/models/customer')
Company = require('server/models/company')


class CompanyFollowersController extends PublicController
  logPrefix: '[company followers controller]'
  urlPrefix: '/companies/:company_id/followers'

  Model: require('server/models/subscription')

  actions: ['create', 'delete']
  auth: true

  mapDoc: (req, res, next) ->
    res.json(success: true)

  create: (req, res, next) ->
    Company.findOne(_id: req.params.company_id).exec (err, companyDoc) =>
      return next(err) if err
      return @notFound(res) unless companyDoc

      req.body =
        customer: req.user._id
        company: companyDoc._id

      @Model.findOne(req.body).exec (err, doc) =>
        return next(err) if err
        return @error(res, company_id: 'alwready_following') if doc

        super(req, res, next)

  CompanyFollowersController::create.type = 'post'

  delete: (req, res, next) ->
    Company.findOne(_id: req.params.company_id).exec (err, companyDoc) =>
      return next(err) if err
      return @notFound(res) unless companyDoc

      model =
        customer: req.user._id
        company: companyDoc._id

      @Model.findOne(model).exec (err, doc) =>
        return next(err) if err
        return @error(res, company_id: 'not_following') unless doc

        req.modelDoc = doc
        super(req, res, next)

  CompanyFollowersController::delete.type = 'delete'

module.exports = new CompanyFollowersController()
