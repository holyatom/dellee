$ = require('jquery')
vent = require('./vent')
config = require('config')
log = require('lib/logger').bind(logPrefix: '[analytics]')
Queue = require('../base/queue')


ANALYTICS_JS = 'https://google-analytics.com/analytics.js'
TRACKING_TIMEOUT = 1000

class Analytics extends Queue
  constructor: ->
    super
    @_initialized = false

    $.getScript(ANALYTICS_JS).done =>
      @ga = global.ga
      return unless @ga

      @ga('create', config.ga.id, config.ga.config)
      @_initialized = true
      @dequeue()

    vent.on('route:after', => @trackPageView())
    vent.on('analytics:event', @trackEvent)

  _ensureCallback: (callback) ->
    called = false
    tid = null

    done = =>
      return if called
      callback?()
      called = true
      clearTimeout(tid) if tid?
      log('tracked event')

    tid = setTimeout(done, TRACKING_TIMEOUT)
    done

  # page: String # URL
  # title: String
  # hitCallback: Function
  # hitCallbackFail: Function
  trackPageView: (options = {}) =>
    options.hitCallback = @ensureCallback(options.hitCallback) if options.hitCallback
    @whenCondition @_initialized, =>
      @ga('send','pageview', options)

  # eventCategory: String # Typically the object that was interacted with (e.g. button)
  # eventAction: String # The type of interaction (e.g. click)
  # eventLabel: String # Useful for categorizing events (e.g. nav buttons)
  # eventValue: Number # Values must be non-negative. Useful to pass counts (e.g. 4 times)
  # hitCallback: Function
  # hitCallbackFail: Function
  trackEvent: (options = {}) =>
    options.hitCallback = @ensureCallback(options.hitCallback) if options.hitCallback
    @whenCondition @_initialized, =>
      @ga('send','trackEvent',
        eventCategory: options.category
        eventAction: options.action
        eventLabel: options.label
      )

module.exports = new Analytics()
