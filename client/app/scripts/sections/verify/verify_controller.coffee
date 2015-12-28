React = require('react')
Controller = require('app/base/controller')
VerifyView = require('./verify_view')
VerificationModel = require('./verification_model')


module.exports = class VerifyControlller extends Controller
  index: (ctx, done) ->
    verification = new VerificationModel(_id: ctx.params.id)

    verification.fetch().then =>
      @renderView(<VerifyView data={{ success: true }} />, done)
    .fail =>
      @renderView(<VerifyView data={{ success: false }} />, done)
