_ = require('lodash')
translit = require('translitit-cyrillic-russian-to-latin')


module.exports =
  format: (string, args...) ->
    return '' unless string

    string = string.replace('%s', args.shift()) while args.length
    string

  slugify: (string) ->
    string = translit(string)
    string = _.startCase(string)
    string.toLowerCase().replace(/[^\w ]+/g,'').replace(/ +/g,'-')
