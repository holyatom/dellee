$ = require('jquery')
vent = require('./vent')
config = require('config')
Queue = require('../base/queue')


FACEBOOK_SDK_JS = 'https://connect.facebook.net/en_US/sdk.js'

class Social extends Queue
  constructor: ->
    super

    @_fbIntialized = false
    @$win = $(global)

    $.getScript(FACEBOOK_SDK_JS).done =>
      @_fbIntialized = true
      global.FB.init(appId: config.fb.app_id, version: config.fb.version)
      @dequeue()

    vent.on('share:vk', @shareVk, @)
    vent.on('share:twitter', @shareTwitter, @)
    vent.on('share:facebook', @shareFacebook, @)

  shareFacebook: (opts = {}) ->
    @whenCondition @_fbIntialized, ->
      global.FB.ui(
        method: 'share'
        href: opts.url or global.location.href
      )

  shareVk: (opts = {}) ->
    params = $.param(
      url: opts.url or global.location.href
    )

    @openPopup("http://vk.com/share.php?#{params}")

  shareTwitter: (opts = {}) ->
    params = $.param(
      url: opts.url or global.location.href
      text: 'Dellee - первый мессенджер акций'
    )

    @openPopup("https://twitter.com/intent/tweet?#{params}")

  openPopup: (url) ->
    position =
      left: @$win.width() / 2 - 300
      top: @$win.height() / 2 - 200

    params = "width=600,height=400,left=#{position.left},top=#{position.top},status=no,toolbar=no"
    popup = global.open(url, 'Поделиться', params)

module.exports = new Social()
