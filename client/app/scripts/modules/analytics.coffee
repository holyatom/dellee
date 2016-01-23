$ = require('jquery')
config = require('config')
log = require('lib/logger').bind(logPrefix: '[analytics]')
vent = require('./vent')
session = require('./session')
Queue = require('../base/queue')


ANALYTICS_JS = 'https://google-analytics.com/analytics.js'
TRACKING_TIMEOUT = 1000
ANALYTICS_DISABLE_KEY = 'analytics:disable'

# Because we love each and every browser
getDoNotTrack = ->
  if typeof global.navigator.doNotTrack isnt 'undefined'
    dntValue = global.navigator.doNotTrack
  else if typeof global.navigator.msDoNotTrack isnt 'undefined'
    dntValue = global.navigator.msDoNotTrack
  else
    dntValue = global.doNotTrack

  dntPositiveValues = ['yes', '1', 1]

  dntValue in dntPositiveValues

class Analytics extends Queue
  constructor: ->
    super
    @_initialized = false
    return if @isDisabled()

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

  isDisabled: -> getDoNotTrack() or session.get(ANALYTICS_DISABLE_KEY)
  disable: (val) -> session.set(ANALYTICS_DISABLE_KEY, val)

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
