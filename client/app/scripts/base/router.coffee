page = require('page')
vent = require('../modules/vent')


module.exports = class Router
  page: page

  run: ->
    @page('*', @createQuery);

    @middleware?()
    @router?()

    @page.start()

    vent.on('navigate', @routeTo)

  routeTo: (url) =>
    @page(url)

  use: (args...) ->
    @page(args...)

  route: (url, action) ->
    [ctrl, method] = action.split('.')
    Controller = @controllers[ctrl]

    throw new Error("undefined controller '#{ctrl}'") unless Controller
    throw new Error("undefined method '#{method}' of 'ctrl' controller") unless Controller::[method]

    @page url, (ctx) =>
      @beforeRoute(ctx)

      @ctor = new Controller()

      if @ctor[method].length > 1
        @ctor[method](ctx, => @afterRoute(ctx))
      else
        @ctor[method](ctx)
        @afterRoute(ctx)

  beforeRoute: (ctx) ->
    @ctor?.destroy()
    @ctor = null

    vent.trigger('route:before', ctx)

  afterRoute: (ctx) ->
    vent.trigger('route:after', ctx)

  createQuery: (ctx, next) =>
    ctx.query = {}

    for param in ctx.querystring.split('&')
      [key, value] = param.split('=')
      ctx.query[key] = value

    next()
