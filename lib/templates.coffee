_ = require('lodash')
fs = require('fs')
Handlebars = require('handlebars')
config = require('config')


cache = {}

readTemplate = (name) ->
  fs.readFileSync("#{__dirname}/../views/mail/#{name}.hbs", encoding: 'utf-8')

compileTemplate = (name, context = {}) ->
  unless cache[name]
    cache[name] = Handlebars.compile(readTemplate(name))

  cache[name](context)

Handlebars.registerPartial('button', readTemplate('partials/button'))
Handlebars.registerHelper('format_email', (email) ->
  email = email.replace(/\@/g, '<span>@</span>')
  email = email.replace(/\./g, '<span>.</span>')
  email
)

module.exports.render = (template, context) ->
  context.config = config

  body = compileTemplate(template, context)

  # get subject from template
  rows = body.split('\n')
  subject = rows[0].trim()
  body = rows[1..].join('\n').trim()

  # render layout
  body = compileTemplate('layout', body: body, config: config)

  # return
  body: body
  subject: subject
