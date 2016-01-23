_ = require('lodash')
config = require('config')
pkg = require('../package')


module.exports =
  getAsset: (name)->
    tmp = name.split('.')
    ext = _.last(tmp)
    name = tmp[0..tmp.length - 2].join('.')
    prefix = if config.debug then '' else '.min'

    "/assets/#{name}#{prefix}.#{ext}?version=#{pkg.version}"
