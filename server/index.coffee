createDomain = require('domain').create

app = require('express')()
exphbs  = require('express-handlebars')
config = require('config')

_ = require('lodash')

pkg = require('../package')
log = require('lib/logger')


loadTemplateEngine = ->
  globals = {
    Date,
    JSON,
    Math,
    RegExp,

    decodeURI,
    decodeURIComponent,
    encodeURI,
    encodeURIComponent,

    isFinite,
    isNaN,
    parseFloat,
    parseInt,

    _,

    config
  }

  app.engine('.hbs', exphbs(
    extname: '.hbs'
    defaultLayout: 'layout'
    layoutsDir: "#{__dirname}/../views"
    helpers: _.extend({}, require('lib/assets'))
  ))

  app.set('view engine', '.hbs')

  _.extend(app.locals, globals)

domainify = (req, res, next)->
  domain = createDomain()
  domain.add(req)
  domain.add(res)
  domain.run(next)
  domain.on('error', next)

preRouteMiddleware = ->
  app.use(domainify)
  app.use(require('morgan')(if config.debug then 'dev' else 'combined'))

  # Intentionally loading in all environments to make local debugging easier
  app.use(require('serve-favicon')("#{__dirname}/../public/favicon.ico"))
  app.use(require('serve-static')("#{__dirname}/../public", redirect: false))

postRouteMiddleware = ->
  app.use(require('errorhandler')(dumpExceptions: true, showStack: true)) if config.debug

module.exports.start = ->
  # Start listening
  app.enable('trust proxy') # usually sitting behind nginx
  app.disable('x-powered-by')

  port = config.server.port
  app.set('port', port)
  app.set('views', "#{__dirname}/../views")
  app.set('json spaces', 2) if config.debug

  loadTemplateEngine()

  preRouteMiddleware()
  controller.use(app) for key, controller of require('./controllers')
  postRouteMiddleware()

  appRoot = "http://#{config.server.ip}:#{port}"
  serverMessage = "Server listening on #{appRoot}"

  if config.server.ip
    app.listen(port, config.server.ip, ->
      log("#{serverMessage} (bound to ip: #{config.server.ip})", 'cyan')
    )
  else
    app.listen(port, -> log("#{serverMessage} (unbound)", 'cyan'))
