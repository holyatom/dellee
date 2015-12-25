module.exports =
  format: (string, args...) ->
    return '' unless string

    string = string.replace('%s', args.shift()) while args.length
    string

  slugify: (string) ->
    string.toLowerCase().replace(/[^\w ]+/g,'').replace(/ +/g,'-')
