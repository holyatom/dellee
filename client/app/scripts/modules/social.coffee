$ = require('jquery')
vent = require('./vent')
config = require('config')


class Social
  constructor: ->
    @$win = $(global)

    vent.on('share:vk', @shareVk, @)
    vent.on('share:twitter', @shareTwitter, @)

  shareVk: ->
    params = $.param(
      url: global.location.href
    )

    @openPopup("http://vk.com/share.php?#{params}")

  shareTwitter: ->
    params = $.param(
      url: global.location.href
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
