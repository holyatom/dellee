BaseRouter = require('./base/router')


module.exports = class Router extends BaseRouter
  router: ->
    @route('/', 'home.index')
    @route('*', 'notFound.index')

if process.browser
  Router::controllers =
    home: require('./controllers/home')
    notFound: require('./controllers/not_found')
