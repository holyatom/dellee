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

module.exports.render = (template, context) ->
  context.config = config

  body = compileTemplate(template, context)
  body = compileTemplate('layout', body: body, config: config)

  body
