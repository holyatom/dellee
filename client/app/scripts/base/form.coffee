_ = require('lodash')
React = require('react')
ReactLink = require('react/lib/ReactLink')
Component = require('./component')


module.exports = class Form extends Component
  _linkStateChange: (keyPath, value) ->
    _.set(@state, keyPath, value)
    @setState(@state)

  _linkValue: (keyPath) ->
    _.get(@state, keyPath)

  lockForm: ->
    @setState(isLocked: true)
    @forceUpdate()

  unlockForm: ->
    @setState(isLocked: false)
    @forceUpdate()

  stateLink: (keyPath) ->
    new ReactLink(@_linkValue(keyPath), @_linkStateChange.bind(@, keyPath))
