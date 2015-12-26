Queue = require('../models/queue')


module.exports =
  run: (data, callback) ->
    console.log('SEND EMAIL', data)
    callback()

  task: (data, callback) ->
    unless data.template and data.to and data.subject
      throw new Error('Required "to" and "template" and "subject"')

    Queue.enqueue('send_email', data, callback)
