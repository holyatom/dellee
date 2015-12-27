React = require('react')
Controller = require('../base/controller')
VerifyView = require('../views/verify')
VerificationModel = require('../models/verification')


module.exports = class VerifyControlller extends Controller
  index: (ctx, done) ->
    verification = new VerificationModel(_id: ctx.params.id)

    verification.fetch().then =>
      @renderView(<VerifyView data={{ success: true }} />, done)
    .fail =>
      @renderView(<VerifyView data={{ success: false }} />, done)
