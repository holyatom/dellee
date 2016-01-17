AdminController = require('server/base/admin_controller')
sendEmail = require('server/tasks/send_email')


class ShopApplicationsController extends AdminController
  logPrefix: '[admin shop applications controller]'
  urlPrefix: '/shop-applications'

  Model: require('server/models/shop_application')

  actions: ['create', 'list', 'get']

  listFields: ['_id', 'shop_name', 'status', 'created']

  create: (req, res, next) ->
    req.body.status = 'new'
    super

  ShopApplicationsController::create.type = 'post'

  mapDoc: (req, res, next) ->
    if not req.oldDoc and req.method is 'POST'
      data =
        to: req.modelDoc.contacts.email
        template: 'welcome_shop'
        context:
          shop: req.modelDoc.toJSON()

      sendEmail.task data, (err) => @log(err, 'red bold') if err

    super


module.exports = new ShopApplicationsController()
