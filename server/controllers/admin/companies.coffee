utils = require('lib/utils')
Q = require('q')
AdminController = require('server/base/admin_controller')
User = require('server/models/user')
Sale = require('server/models/sale')
File =require('server/models/file')


class CompaniesController extends AdminController
  logPrefix: '[admin companies controller]'
  urlPrefix: '/companies'

  auth: true

  Model: require('server/models/company')

  actions: ['create', 'list', 'get', 'delete', 'update']

  listFields: ['_id', 'name', 'slug']
  updateFields: ['name', 'slug', 'logo_url']

  list: -> super
  CompaniesController::list.roles = ['admin']

  get: (req, res, next) ->
    unless @canViewAndEdit(req)
      return @error(res, 'role_required', 401)

    super

  CompaniesController::get.url = '/:id'


  create: -> super

  CompaniesController::create.type = 'post'
  CompaniesController::create.roles = ['admin']


  update: (req, res, next) ->
    unless @canViewAndEdit(req)
      return @error(res, 'role_required', 401)

    super

  CompaniesController::update.type = 'put'
  CompaniesController::update.url = '/:id'


  delete: (req, res, next) ->
    Q.all([
      User.remove(company: req.modelDoc._id)
      Sale.remove(company: req.modelDoc._id)
    ])
    .then =>
      super(req, res, next)
    .fail (err) ->
      next(err)

  CompaniesController::delete.type = 'delete'
  CompaniesController::delete.url = '/:id'
  CompaniesController::delete.roles = ['admin']


  mapDoc: (req, res, next) ->
    item = req.modelDoc.toJSON()

    File.findOne(url: item.logo_url).exec (err, fileDoc) ->
      return next(err) if err

      item.logo = fileDoc.toJSON() if fileDoc
      res.json(item)


  canViewAndEdit: (req) ->
    (req.adminUser.role is 'company_user' and req.adminUser.company.equals(req.params.id)) or req.adminUser.role is 'admin'

module.exports = new CompaniesController()
