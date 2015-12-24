pkg = require('../package')


module.exports =
  getAsset: (name)->
    "/assets/#{name}?version=#{pkg.version}"
