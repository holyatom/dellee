_ = require('lodash')
mongoose = require('mongoose')
v = require('lib/validators')
Schema = require('../base/schema')


schema = Schema(
  task:
    type: String
    required: v.required()

  data:
    type: mongoose.Schema.Types.Mixed

  status:
    type: String
    required: v.required()
    enum: v.enum(['new', 'running', 'completed', 'failed'])

  created:
    type: Date

  updated:
    type: Date
)

schema.methods.complete = (callback) ->
  @status = 'completed'
  @save(callback)

schema.methods.fail = (callback) ->
  @status = 'failed'
  @save(callback)

schema.methods.run = (callback) ->
  @status = 'running'
  @save(callback)

Queue = mongoose.model('Queue', schema)

Queue.enqueue = (task, data, callback) ->
  taskModule = require("../tasks/#{task}")

  unless _.isFunction(taskModule.run)
    throw new Error("../tasks/#{task}.run is not callable")

  taskModel = new Queue(
    task: task
    data: data
    status: 'new'
  )

  taskModel.save(callback)

Queue.getNew = (chunkSize, callback) ->
  query = Queue
    .find(status: 'new')
    .sort(updated: 'desc')
    .limit(chunkSize)

  query.exec(callback)


module.exports = Queue
