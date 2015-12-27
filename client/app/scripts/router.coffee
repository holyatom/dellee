BaseRouter = require('./base/router')


module.exports = class Router extends BaseRouter
  router: ->
    @route('/', 'home.index')
    @route('/verify/:id', 'verify.index')
    @route('*', 'notFound.index')

if process.browser
  Router::controllers =
    home: require('./controllers/home')
    verify: require('./controllers/verify')
    notFound: require('./controllers/not_found')
