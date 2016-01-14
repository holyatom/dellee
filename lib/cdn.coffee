config = require('config')
crypto = require('crypto')
fs = require('fs')
path = require('path')

PREFIX_LENGTH = 2

createDir = (dir) ->
  # Prevent endless recursion.
  return if dir is config.cdn.storage or dir is '/'

  try
    fs.mkdirSync(dir, '0755')
  catch err
    if err.code is 'ENOENT'
      createDir(path.dirname(dir))
    else
      throw err
    fs.mkdirSync(dir, '0755')

module.exports.createDir = createDir

module.exports.getWriteStream = (prefix, ext, cb) ->
  if ext[0] isnt '.'
    ext = ".#{ext}"
  while true
    hash = crypto.createHash('md5')
    hash.update(Math.random().toString())
    rnd = hash.digest('hex').toString()
    url = "/#{prefix}/#{rnd[0...PREFIX_LENGTH]}/#{rnd[PREFIX_LENGTH..]}#{ext}"
    file = "#{config.cdn.storage}#{url}"
    break unless fs.existsSync(file)

  result =
    file: file
    relativeUrl: url
    url: url
  if config.cdn.host
    result.url = "//#{config.cdn.host}#{result.url}"

  try
    fd = fs.openSync(file, 'w')
  catch err
    if err.code is 'ENOENT'
      createDir(path.dirname(file))
      fd = fs.openSync(file, 'w')
    else
      throw err

  result.stream = fs.createWriteStream(null, {fd})
  cb(null, result)

module.exports.getPathByUrl = (url) ->
  "#{config.cdn.storage}/#{url}"

module.exports.getAbsoluteUrl = (url) ->
  if config.cdn?.host
    "//#{config.cdn.host}#{url}"
  else
    # Local debug.
    url
