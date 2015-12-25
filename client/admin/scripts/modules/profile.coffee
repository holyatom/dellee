_ = require('underscore')
Backbone = require('backbone')
vent = require('./vent')
session = require('./session')
Model = require('../base/model')


class Profile extends Model
  resourceUrl: '/users/profile'

  defaults:
    _id: 0
    timestamp: 0

  initialize: ->
    return unless process.browser

    if _id = session.get('user_id')
      @set({ _id })
      @fetch()
      @setTokenHeaders()
      @fetch(ajaxSync: true).fail(@logout)

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
      session.set(user_id: @id)
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
