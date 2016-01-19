_ = require('underscore')
{ Events } = require('backbone')


class Queue
  constructor: ->
    _.extend(@, Events)
    @queue = []

  dequeue: =>
    if @queue.length
      callback() for callback in @queue
      @queue.length = 0

  whenCondition: (condition, callback)->
    isTrue = if _.isFunction(condition) then condition() else condition

    if isTrue
      callback()
    else
      @queue.push(callback)

module.exports = Queue
