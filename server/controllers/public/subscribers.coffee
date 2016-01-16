PublicController = require('server/base/public_controller')
sendEmail = require('server/tasks/send_email')


class SubscribersController extends PublicController
  logPrefix: '[subscribers controller]'
  urlPrefix: '/subscribers'

  Model: require('server/models/subscriber')

  actions: ['create']

  mapDoc: (req, res, next) ->
    if not req.oldDoc and req.method is 'POST'
      data =
        to: req.modelDoc.email
        template: 'welcome'
        context:
          email: req.modelDoc.email

      sendEmail.task data, (err) => @log(err, 'red bold') if err

    res.json(success: true)

module.exports = new SubscribersController()
