AdminController = require('server/base/admin_controller')
sendEmail = require('server/tasks/send_email')


class CompanyApplicationsController extends AdminController
  logPrefix: '[admin company applications controller]'
  urlPrefix: '/company-applications'

  DEFAULT_ORDER: 'is_replied created'

  Model: require('server/models/company_application')

  actions: ['create', 'list', 'get', 'update']

  listFields: ['_id', 'company_name', 'is_replied', 'status', 'created']
  updateFields: ['is_replied', 'notes']

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

      sendEmail.task data, (err) => @log(err, 'red bold') if err

    super


module.exports = new CompanyApplicationsController()
