_ = require('underscore')
Backbone = require('backbone')
vent = require('./vent')
session = require('./session')
Model = require('../base/model')


class Profile extends Model
  resourceUrl: '/customers/profile'

  defaults:
    _id: 0
    timestamp: 0

  initialize: ->
    return unless process.browser

    if _id = session.get('user_id')
      @set({ _id })
      @fetch()
      @setTokenHeaders()
      @fetch(ajaxSync: true).then(=> @save()).fail(@logout)

  setTokenHeaders: ->
    headers = 'x-access-token': @get('token').value
    $.ajaxSetup({ headers })

  unsetTokenHeaders: ->
    headers = 'x-access-token': ''
    $.ajaxSetup({ headers })

  reset: ->
    @destroy()
    @clear(silent: true)
    @set(@defaults, silent: true)
    @save()

  login: (data) ->
    dfd = @$(type: 'post', url: "#{@apiRoot}/auth", data: data).then (resp) =>
      @set(token: resp.token, silent: true)
      @setTokenHeaders()

      @fetch(ajaxSync: true)
    .then =>
      @set({ timestamp: Date.now() }, silent: true)
      @save()
      session.set(user_id: @id)
      vent.trigger('user:login')

    dfd

  logout: =>
    @reset()
    session.reset()
    @unsetTokenHeaders()
    vent.trigger('user:logout')

  authorized: -> !!@id

if process.browser
  Profile::localStorage = new Backbone.LocalStorage('app:user')

module.exports = new Profile()
