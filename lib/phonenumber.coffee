_ = require('lodash')


PHONE_LENGTH = 10
COUNTRY_CODE = 7
PREFIXES = [
  '70',
  '77',
  '74'
]

module.exports = (phone) ->
  return null unless phone

  phone = phone.replace(/[\-\(\)\s]/g,'')

  if _.startsWith(phone, '+')
    phone = phone[2...] # remove `+{COUNTRY_CODE}`
  else if _.startsWith(phone, '8') and phone.length is PHONE_LENGTH + 1
    phone = phone[1...] # remove `8`

  return 'INVALID' if phone.length isnt PHONE_LENGTH or phone[0..1] not in PREFIXES  # incorrect phone type

  "+#{COUNTRY_CODE}#{phone}"
