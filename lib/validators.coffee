ALPHANUMERIC_REGEXP = /^[a-zA-Z0-9]*$/
EMAIL_REGEXP = /^[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+$/


module.exports =
  maxLength: (max) ->
    message: 'longer_than_allowed'
    validator: (val) -> val.length <= max

  minLength: (min) ->
    message: 'shorter_than_allowed'
    validator: (val) -> val.length >= min

  alphanumeric: ->
    message: 'alphanumeric'
    validator: (val) -> ALPHANUMERIC_REGEXP.test(val)

  email: ->
    message: 'bad_email'
    validator: (val) -> EMAIL_REGEXP.test(val)

  # Built-in validators
  required: -> [true, 'required']
