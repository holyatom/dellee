config = require('config')
mongoose = require('mongoose')
dispatchQueue = require('./dispatch_queue')
log = require('lib/logger').bind(logPrefix: '[tasks]')


database = (callback) ->
  mongoose.connect("mongodb://#{config.mongodb.host}/#{config.mongodb.database}")

  mongoose.connection.on 'error', (err) =>
    log("mongodb operation failed: #{err}", 'red bold')

  mongoose.connection.once 'open', =>
    log('mongodb was connected', 'green')
    callback?()

database ->
  dispatchQueue.run()
