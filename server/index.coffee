_ = require('lodash')
config = require('config')
express = require('express')
domain = require('domain')
morgan = require('morgan')
errorhandler = require('errorhandler')
bodyParser = require('body-parser')
middlewares = require('./middlewares')
exphbs = require('express-handlebars')
database = require('lib/database')
helmet = require('helmet')
compress = require('compression')


class Server
  log: require('lib/logger')
  logPrefix: '[server]'

  constructor: ->
    @app = express()

  preRouteMiddleware: ->
    @app.use((req, res, next) ->
      _domain = domain.create()
      _domain.add(req)
      _domain.add(res)
      _domain.run(next)
      _domain.on('error', next)
    )

    @app.use(helmet())

    @app.use(morgan(if config.debug then 'dev' else 'combined'))

    # Enable gzip
    @app.use(compress())

    # Set publis assets.
    @app.use(require('serve-favicon')("#{__dirname}/../public/favicon.ico"))
    @app.use(require('serve-static')("#{__dirname}/../public", redirect: false))
    @app.use(require('serve-static')("#{__dirname}/../cdn", redirect: false))

    # Set language.
    @app.use(middlewares.lang)

    # Parse application/json.
    @app.use(bodyParser.json(limit: 1024 * 1024))

    # Authenticate admin by JSON Web Token.
    this.app.use(middlewares.adminJwt)

    # Authenticate by JSON Web Token.
    this.app.use(middlewares.jwt)

  postRouteMiddleware: ->
    if config.debug
      @app.use(errorhandler(dumpExceptions: true, showStack: true))
    else
      @app.use((err, req, res, next) =>
        @log(err.stack or err, 'red bold')
        middlewares.serverError(req, res)
      )

    @app.use((req, res, next) -> middlewares.notFound(req, res))

  loadTemplateEngine: ->
    globals = {
      Date
      JSON
      Math
      RegExp

      decodeURI
      decodeURIComponent
      encodeURI
      encodeURIComponent

      isFinite
      isNaN
      parseFloat
      parseInt

      _

      config
    }

    @app.engine('.hbs', exphbs(
      extname: '.hbs'
      defaultLayout: 'layout'
      layoutsDir: "#{__dirname}/../views"
      partialsDir: "#{__dirname}/../views/partials"
      helpers: _.extend({}, require('lib/assets'))
    ))

    @app.set('view engine', '.hbs')

    _.extend(@app.locals, globals)

  start: ->
    port = config.server.port
    @app.set('port', port)
    @app.set('views', "#{__dirname}/../views")

    @loadTemplateEngine()

    @preRouteMiddleware()

    unless config.env is 'production'
      controller.use(@app) for controller in require('./controllers')
    else
      @app.get('*', (req, res, next) -> res.render('layout_locked', layout: false))

    @postRouteMiddleware()

    database =>
      @app.listen config.server.port, config.server.ip, =>
        @log("server running on #{config.server.ip}:#{config.server.port}", 'green')

module.exports = new Server()
