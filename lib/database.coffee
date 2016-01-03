mongoose = require('mongoose')
config = require('config')
log = require('lib/logger').bind(logPrefix: '[database]')


module.exports = (callback) ->
  mongoose.connect("mongodb://#{config.mongodb.host}/#{config.mongodb.database}")

  mongoose.connection.on 'error', (err) ->
    log("mongodb operation failed: #{err}", 'red bold')

  mongoose.connection.once 'open', ->
    log('mongodb was connected', 'green')
    callback?()
