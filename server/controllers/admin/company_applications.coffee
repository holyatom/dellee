AdminController = require('server/base/admin_controller')
tasks = require('server/tasks')


class CompanyApplicationsController extends AdminController
  logPrefix: '[admin company applications controller]'
  urlPrefix: '/company-applications'

  DEFAULT_ORDER: 'is_replied created'

  Model: require('server/models/company_application')

  actions: ['create', 'list', 'get', 'update', 'delete']

  listFields: ['_id', 'company_name', 'is_replied', 'status', 'created']
  updateFields: ['is_replied', 'notes']

  get: -> super
  CompanyApplicationsController::get.url = '/:id'
  CompanyApplicationsController::get.roles = ['admin', 'moderator']

  update: -> super
  CompanyApplicationsController::update.type = 'put'
  CompanyApplicationsController::update.url = '/:id'
  CompanyApplicationsController::update.roles = ['admin', 'moderator']

  delete: -> super
  CompanyApplicationsController::delete.type = 'delete'
  CompanyApplicationsController::delete.url = '/:id'
  CompanyApplicationsController::delete.roles = ['admin']

  list: -> super
  CompanyApplicationsController::list.roles = ['admin', 'moderator']

  create: (req, res, next) ->
    req.body.status = 'new'
    super

  CompanyApplicationsController::create.type = 'post'

  mapDoc: (req, res, next) ->
    if not req.oldDoc and req.method is 'POST'
      data =
        to: req.modelDoc.contacts.email
        template: 'welcome_company'
        context:
          company: req.modelDoc.toJSON()

      tasks.sendEmail(data, (err) => @log(err, 'red bold') if err)

    if req.method is 'POST'
      res.json(success: true)
    else
      super


module.exports = new CompanyApplicationsController()
