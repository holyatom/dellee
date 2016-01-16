AdminController = require('server/base/admin_controller')
sendEmail = require('server/tasks/send_email')


class ShopRegistersController extends AdminController
  logPrefix: '[admin shop registers controller]'
  urlPrefix: '/shop-registers'

  Model: require('server/models/shop_register')

  actions: ['create', 'list', 'get']

  listFields: ['_id', 'name', 'created']

  mapDoc: (req, res, next) ->
    if not req.oldDoc and req.method is 'POST'
      data =
        to: req.modelDoc.contacts.email
        template: 'welcome_shop'
        context:
          shop: req.modelDoc.toJSON()

      sendEmail.task data, (err) => @log(err, 'red bold') if err

    super


module.exports = new ShopRegistersController()
