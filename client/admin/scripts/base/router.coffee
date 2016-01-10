_ = require('lodash')
page = require('page')
vent = require('../modules/vent')


module.exports = class Router
  page: page

  defaults:
    force: false

  contructor: ->
    @resetOptions()

  resetOptions: ->
    @options = _.clone(@defaults)

  run: ->
    @page('*', @createQuery);

    @middleware?()
    @router?()

    @page.start()

    vent.on('navigate', @routeTo)

  routeTo: (url, opts) =>
    _.extend(@options, opts)
    @page(url)

  route: (url, middlewares..., action) ->
    [ctrl, method] = action.split('.')
    Controller = @controllers[ctrl]

    throw new Error("undefined controller '#{ctrl}'") unless Controller
    throw new Error("undefined method '#{method}' of 'ctrl' controller") unless Controller::[method]

    @page(url, middleware) for middleware in middlewares

    @page url, (ctx) =>
      @beforeRoute(ctx)

      @ctor = new Controller()

      process.nextTick =>
        if @ctor[method].length > 1
          @ctor[method](ctx, => @afterRoute(ctx))
        else
          @ctor[method](ctx)
          @afterRoute(ctx)

  beforeRoute: (ctx) ->
    @ctor?.destroy(force: @options.force)
    @ctor = null

    vent.trigger('route:before', ctx)

  afterRoute: (ctx) ->
    vent.trigger('route:after', ctx)
    @resetOptions()

  createQuery: (ctx, next) =>
    ctx.query = {}

    for param in ctx.querystring.split('&')
      [key, value] = param.split('=')
      ctx.query[key] = value

    next()
