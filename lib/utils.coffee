_ = require('lodash')


module.exports =
  format: (string, args...) ->
    return '' unless string

    string = string.replace('%s', args.shift()) while args.length
    string

  slugify: (string) ->
    string = _.startCase(string)
    string.toLowerCase().replace(/[^\w ]+/g,'').replace(/ +/g,'-')
