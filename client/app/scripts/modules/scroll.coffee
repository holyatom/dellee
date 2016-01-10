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

  scroll: (options) ->
    return @$win.scrollTop() unless options

    _.defaults(options, @defaults)

    if options.target
      $target = $(options.target)
      options.pos = $target.offset().top

    if options.animate
      @$scrollable.animate({ scrollTop: options.pos }, options.duration)
    else
      @$win.scrollTop(options.pos)

  afterRoute: (ctx) ->
    if ctx.hash
      @scroll(target: "##{ctx.hash}", animate: false)
    else
      @scroll(animate: false)

module.exports = new Scroll()
