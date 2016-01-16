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
    renderData = templates.render(data.template, data.context)

    transport.sendMail(
      from: data.from or config.mail.default_from
      to: data.to
      subject: data.subject or renderData.subject
      html: renderData.body
      callback
    )

  task: (data, callback) ->
    unless data.template and data.to
      throw new Error('Required "to" and "template"')

    Queue.enqueue('send_email', data, callback)
