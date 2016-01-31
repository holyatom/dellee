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
    pathExcludes: []
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

    isNeededExt = if opts.onlyExt then extname is opts.onlyExt else true
    excluded = origName in opts.excludes or fullpath in opts.pathExcludes

    if not isNeededExt or excluded
      return

    if opts.flat
      res.push(require(fullpath))
    else
      res[name] = require(fullpath)
  )

  res

module.exports = { loadDir }
