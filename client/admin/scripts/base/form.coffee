_ = require('lodash')
$ = require('jquery')
React = require('react')
ReactLink = require('react/lib/ReactLink')
Component = require('./component')


module.exports = class Form extends Component
  _linkStateChange: (keyPath, value) ->
    _.set(@state, keyPath, value)
    @setState(@state)

  _linkValue: (keyPath) ->
    _.get(@state, keyPath)

  componentDidMount: ->
    if @refs.form
      @$form = $(@refs.form)

  lockForm: ->
    @setState(isLocked: true)
    @forceUpdate()

  unlockForm: ->
    @setState(isLocked: false)
    @forceUpdate()

  resetForm: ->
    @$form.find('.has-error').removeClass('has-error')
    @$form.find('.help-block.with-errors').text('')

  showSuccessMessage: ->
    @setState(success: true, error: false)
    @forceUpdate()

  showInputError: (key, message) ->
    $input = @$form.find("[name=\"#{key}\"]")
    $formGroup = $input.closest('.form-group')
    $formGroup.addClass('has-error') if $formGroup.length

    $help = $input.next('.help-block')
    $help.text(message.message)

  showErrorMessage: (xhr) ->
    @resetForm() if @$form
    message = 'Ошибка сети'

    if error = xhr.responseJSON?.error
      if (fields = error.fields) and @$form
        @showInputError(key, value) for key, value of fields
        @setState(success: false, error: false)
        return
      else
        message = error.message or message

    @setState(success: false, error: { message })
    @forceUpdate()

  stateLink: (keyPath) ->
    new ReactLink(@_linkValue(keyPath), @_linkStateChange.bind(@, keyPath))
