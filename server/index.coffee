_ = require('lodash')
config = require('config')
express = require('express')
mongoose = require('mongoose')
domain = require('domain')
morgan = require('morgan')
errorhandler = require('errorhandler')
bodyParser = require('body-parser')
middlewares = require('./middlewares')
exphbs = require('express-handlebars')


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

    @app.use(morgan(if config.debug then 'dev' else 'combined'))

    # Set publis assets.
    @app.use(require('serve-favicon')("#{__dirname}/../public/favicon.ico"))
    @app.use(require('serve-static')("#{__dirname}/../public", redirect: false))

    # Set language.
    @app.use(middlewares.lang)

    # Parse application/json.
    @app.use(bodyParser.json(limit: 1024 * 1024))

  postRouteMiddleware: ->
    if config.debug
      @app.use(errorhandler(dumpExceptions: true, showStack: true))
    else
      @app.use((err, req, res) =>
        @log(err.stack or err, 'red bold')
        middlewares.serverError(res)
      )

    @app.use((req, res, next) -> middlewares.notFound(res))

  database: (callback) ->
    mongoose.connect("mongodb://#{config.mongodb.host}/#{config.mongodb.database}")

    mongoose.connection.on 'error', (err) =>
      @log("mongodb operation failed: #{err}", 'red bold')

    mongoose.connection.once 'open', =>
      @log('mongodb was connected', 'green')
      callback?()

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
    controller.use(@app) for key, controller of require('./controllers')
    @postRouteMiddleware()

    @database =>
      @app.listen config.server.port, config.server.ip, =>
        @log("server running on #{config.server.ip}:#{config.server.port}", 'green')

module.exports = new Server()
