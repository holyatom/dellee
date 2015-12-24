_ = require('lodash')
langs = require('config/langs')
{ format } = require('lib/utils')


# Returns HTTP error.
#
# res   - The Express Response as {Response}.
# error - The error as {mixed}.
# code  - The HTTP status code as {Number}.

module.exports = (res, error, code = 422) ->
  lang = langs[res.locals?.lang or 'en']

  unless code is 422
    return res.status(code).json(
      error:
        code: error
        message: lang.errors[error]
    ).end()

  fields = {}

  for key, value of error
    value = value.message or value

    fields[key] =
      code: value
      message: _.capitalize(format(lang.errors[value], key))

  res.status(code).json(
    error:
      code: 'validation_failed'
      fields: fields
  ).end()
