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

  showSuccessMessage: ->
    @setState(success: true, error: false)
    @forceUpdate()

  showErrorMessage: (xhr) ->
    message = 'Ошибка сети'

    if error = xhr.responseJSON?.error
      if fields = error.fields
        validations = (value.message for key, value of fields)
        message = validations.join(', ')
      else
        message = error.message

    @setState(success: false, error: { message })
    @forceUpdate()

  stateLink: (keyPath) ->
    new ReactLink(@_linkValue(keyPath), @_linkStateChange.bind(@, keyPath))
