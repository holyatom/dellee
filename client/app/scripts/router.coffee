BaseRouter = require('./base/router')


class Router extends BaseRouter
  controllers:
    home: require('./controllers/home')
    notFound: require('./controllers/not_found')

  router: ->
    @route('/', 'home.index')
    @route('*', 'notFound.index')

module.exports = new Router()
