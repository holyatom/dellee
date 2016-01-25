AdminController = require('server/base/admin_controller')
sendEmail = require('server/tasks/send_email')


class CompanyApplicationsController extends AdminController
  logPrefix: '[admin company applications controller]'
  urlPrefix: '/company-applications'

  Model: require('server/models/company_application')

  actions: ['create', 'list', 'get']

  listFields: ['_id', 'company_name', 'status', 'created']

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
