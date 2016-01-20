_ = require('lodash')
$ = require('jquery')
vent = require('./vent')


class Scroll
  defaults:
    pos: 0
    animate: true
    duration: 200
    target: null

  constructor: ->
    @$win = $(global)
    @$scrollable = $('html, body')

    vent.on('route:after', @afterRoute, @)
    vent.on('scroll', @scroll, @)
    vent.on('scroll:lock', @lock, @)
    vent.on('scroll:unlock', @unlock, @)

  scroll: (options, callback) ->
    return @$win.scrollTop() unless options

    _.defaults(options, @defaults)

    if options.target
      $target = $(options.target)
      options.pos = $target.offset().top

    if options.animate
      @$scrollable.animate({ scrollTop: options.pos }, options.duration, callback)
    else
      @$win.scrollTop(options.pos)
      callback?()

  afterRoute: (ctx, props) ->
    return unless props.initialized

    if ctx.hash
      @scroll(target: "##{ctx.hash}", animate: false)
    else
      @scroll(animate: false)

  lock: ->
    @$scrollable.on('touchmove', @_preventDefault)
    @$scrollable.addClass('locked_scroll')

  unlock: =>
    @$scrollable.off('touchmove', @_preventDefault)
    @$scrollable.removeClass('locked_scroll')

module.exports = new Scroll()
