domain = require('domain')
config = require('config')
async = require('async')
log = require('lib/logger').bind(logPrefix: '[dispatch queue]')
Queue = require('../models/queue')
database = require('lib/database')


failTask = (err, task, callback) ->
  msg = err.stack or err.message or err
  log("Got error: #{msg}, fail task id=#{task._id}", 'red bold')

  task.fail(callback) unless task.status is 'failed'

runTask = (task, callback) ->
  log("Run task #{task.task} (id=#{task._id})")

  _domain = domain.create()

  _domain.on('error', (err) -> failTask(err, task, callback))

  _domain.run ->
    func = require("./#{task.task}").run

    task.run (err) ->
      return failTask(err, task, callback) if err

      func task.data, (err) ->
        return failTask(err, task, callback) if err

        log("Complete task id=#{task._id}")
        task.complete(callback)

processChunk = (err, tasks) ->
  return run() unless tasks.length or err

  log("Got tasks from queue, id=#{(t._id for t in tasks).join(',')}")
  async.parallel((runTask.bind(null, task) for task in tasks), run)

run = ->
  setTimeout(
    Queue.getNew.bind(Queue, config.queue.chunk_size, processChunk)
    config.queue.timeout
  )

database -> run()
