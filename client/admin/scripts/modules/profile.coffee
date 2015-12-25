_ = require('underscore')
Backbone = require('backbone')
vent = require('./vent')
session = require('./session')
Model = require('../base/model')


class Profile extends Model
  idAttribute: 'username'

  defaults:
    username: 0
    timestamp: 0

  initialize: ->
    return unless process.browser

    if username = session.get('user_username')
      @set({ username })
      @fetch()
      @setTokenHeaders()

  setTokenHeaders: ->
    headers = 'x-access-admin-token': @get('token').value
    $.ajaxSetup({ headers })

  unsetTokenHeaders: ->
    headers = 'x-access-admin-token': ''
    $.ajaxSetup({ headers })

  reset: ->
    @destroy()
    @clear(silent: true)
    @set(@defaults, silent: true)
    @save()

  login: (data) ->
    dfd = @$(type: 'post', url: "#{@apiRoot}/admin-auth", data: data)

    dfd.then (profile) =>
      @set({ timestamp: Date.now() }, silent: true)
      @save(profile)
      session.set(user_username: @id)
      @setTokenHeaders()
      vent.trigger('user:login')

    dfd

  logout: =>
    @reset()
    session.reset()
    @unsetTokenHeaders()
    vent.trigger('user:logout')

  authorized: -> !!@id

  is: (role, opts = {}) ->
    _role = @get('role')
    _role is role or (_role is 'admin' and not opts.strict)

if process.browser
  Profile::localStorage = new Backbone.LocalStorage('admin:user')

module.exports = new Profile()
