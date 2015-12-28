Backbone = require('backbone')
Model = require('../base/model')


class Session extends Model
  defaults:
    _id: 'static'
    timestamp: 0

  initialize: ->
    return unless process.browser

    @fetch()
    @on('change', @handleChange, @)

  reset: ->
    @destroy()
    @clear(silent: true)
    @set(@defaults, silent: true)
    @save()

  handleChange: ->
    @set({ timestamp: Date.now() }, silent: true)
    @save()

if process.browser
  Session::localStorage = new Backbone.LocalStorage('app:session')

module.exports = new Session()
