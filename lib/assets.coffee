_ = require('lodash')
config = require('config')
fs = require('fs')
pkg = require('../package')


unless config.debug
  hashmap = fs.readFileSync("#{__dirname}/../public/assets/hashmap.json", 'utf8')
  hashmap = JSON.parse(hashmap)

module.exports =
  getAsset: (name)->
    tmp = name.split('.')
    ext = _.last(tmp)
    name = tmp[0..tmp.length - 2].join('.')

    unless config.debug
      name = hashmap["#{name}.min.#{ext}"]
    else
      name += ".#{ext}"

    "/assets/#{name}"
