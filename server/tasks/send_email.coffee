config = require('config')
nodemailer = require('nodemailer')
mg = require('nodemailer-mailgun-transport')
templates = require('lib/templates')
Queue = require('../models/queue')


transport = nodemailer.createTransport(mg(
  auth:
    api_key: config.mail.mailgun.key
    domain: config.mail.mailgun.domain
))

module.exports =
  run: (data, callback) ->
    transport.sendMail(
      from: data.from or config.mail.default_from
      to: data.to
      subject: data.subject
      html: templates.render(data.template, data.context)
      callback
    )

  task: (data, callback) ->
    unless data.template and data.to and data.subject
      throw new Error('Required "to" and "template" and "subject"')

    Queue.enqueue('send_email', data, callback)
