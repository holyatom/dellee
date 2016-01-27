_ = require('lodash')
fs = require('fs')
path = require('path')
parsePath = require('parse-filepath')

# Public: Require each coffee file from dirname and store it as an
#         object's property.
#
# dirname   - The directory to read files from as {string}.
# excludes  - The list of filenames for excluding as {Array}.
# onlyExt   - The required files extension as {string}.
#
# Returns the object with proprties named like required files as `object`.
loadDir = (dirname, opts = {}) ->
  defaults =
    excludes: ['index']
    onlyExt: '.coffee'
    flat: false
    camelCase: false

  _.defaults(opts, defaults)

  res = if opts.flat then [] else {}

  fs.readdirSync(dirname).forEach((file) ->
    {name, extname} = parsePath(file)
    return if name[0] is '_'

    origName = name
    name = _.camelCase(name) if opts.camelCase
    fullpath = path.join(dirname, file)

    if not extname and fs.statSync(fullpath).isDirectory()
      # Load nested directories recursively.
      if opts.flat
        res = res.concat(loadDir(fullpath, opts))
      else
        res[name] = loadDir(fullpath, opts)

    return if (opts.onlyExt and extname isnt opts.onlyExt) or origName in opts.excludes

    if opts.flat
      res.push(require(fullpath))
    else
      res[name] = require(fullpath)
  )

  res

module.exports = { loadDir }
