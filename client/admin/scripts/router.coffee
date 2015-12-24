BaseRouter = require('./base/router')


class Router extends BaseRouter
  controllers:
    home: require('./controllers/home')
    notFound: require('./controllers/not_found')

  router: ->
    @route('/admin', 'home.index')
    @route('/admin/*', 'notFound.index')

module.exports = new Router()
