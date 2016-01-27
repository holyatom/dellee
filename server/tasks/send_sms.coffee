_ = require('lodash')
fs = require('fs')
request = require('request')
config = require('config')
Queue = require('server/models/queue')
templates = require('lib/templates')


URL = 'https://rest.nexmo.com/sms/json'

# Public: Sends a sms message.
#
# data - The sms message's data as {Object}: text, from, to.
# cb   - The task's callback as {Function}.
module.exports.run = (data, cb) ->
  if data.template
    rendered = templates.render(data.template, data.context)
    data.text = rendered.body

  isUnicode = new Buffer(data.text).length isnt data.text.length
  from = data.from or config.sms.default_from

  request.post(
    url: URL
    json: true
    form:
      api_key: config.sms.nexmo.key
      api_secret: config.sms.nexmo.secret
      type: if isUnicode then 'unicode' else 'text'
      from: from
      title: from
      to: data.to
      text: data.text
    (err, resp, body) ->
      if err or resp.statusCode isnt 200 or body.messages[0].status isnt '0'
        cb(err, body)
      else
        cb(null, body)
  )

module.exports.task = (data, cb) ->
  unless (data.text or data.template) and data.to
    throw new Error('Required "to" and "text" or "template"')

  unless _.startsWith(data.to, '+')
    data.to = data.to.replace('+', '')

  Queue.enqueue('send_sms', data, cb)
