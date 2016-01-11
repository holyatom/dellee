PublicController = require('server/base/public_controller')
sendEmail = require('server/tasks/send_email')


class SubscribersController extends PublicController
  logPrefix: '[subscribers controller]'
  urlPrefix: '/subscribers'

  Model: require('server/models/subscriber')

  actions: ['create']

  create: (req, res, next) ->
    model = new @Model(req.body)

    model.validate (err) =>
      return @error(res, err.errors) if err

      model.save (err, doc) =>
        return next(err) if err
        req.modelItem = doc

        data =
          to: req.modelItem.email
          subject: 'Приветствуем'
          template: 'welcome'
          context:
            email: req.modelItem.email

        sendEmail.task data, (err) =>
          return next(err) if err
          res.json(sucess: true)

  SubscribersController::create.type = 'post'

module.exports = new SubscribersController()
