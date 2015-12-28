ALPHANUMERIC_REGEXP = /^[a-zA-Z0-9]*$/
EMAIL_REGEXP = /^[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+$/
BAD_USERNAMES = require('./bad_usernames')

module.exports =
  username: ->
    message: 'bad_username'
    validator: (val) -> not BAD_USERNAMES[val]

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

  enum: (values) ->
    values: values
    message: 'bad_enum_value'
