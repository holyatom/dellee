module.exports =
  format: (string, args...) ->
    string = string.replace('%s', args.shift()) while args.length
    string
