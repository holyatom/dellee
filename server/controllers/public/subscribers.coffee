PublicController = require('server/base/public_controller')
sendEmail = require('server/tasks/send_email')


class SubscribersController extends PublicController
  logPrefix: '[subscribers controller]'
  urlPrefix: '/subscribers'

  Model: require('server/models/subscriber')

  actions: ['create']

  mapDoc: (req, res, next) ->
    unless req.oldDoc
      data =
        to: req.modelDoc.email
        subject: 'Приветствуем'
        template: 'welcome'
        context:
          email: req.modelDoc.email

      sendEmail.task data, (err) => @log(err, 'red bold') if err

    super

module.exports = new SubscribersController()
