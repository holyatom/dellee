_ = require('lodash')
$ = require('jquery')
Dropzone = require('dropzone')
config = require('config')


defaultOptions =
  # FIXME: change to dellee endpoint - "#{config.api_root}/upload"
  url: 'https://api.cloudinary.com/v1_1/atomiomi/image/upload'
  paramName: 'file'

  # headers:
  #   'Cache-Control': '' # remove cache control header
  #   'X-AUTH-TOKEN': profile.get('toke')?.value


module.exports = class Uploader extends Dropzone
  defaultOptions: _.defaultsDeep(defaultOptions, Dropzone::defaultOptions)

  constructor: ->
    super

    @$el = $(@element)

    @on('addedfile', @handleAdd)
    @on('removedfile', @handleRemove)
    @on('error', @handleError)
    @on('success', @handleSuccess)

    # FIXME: Remove when endpoint is ready
    @on 'sending', (file, xhr, formData) ->
      formData.append('upload_preset', 'kriwxybd')

  handleAdd: (file) =>
    file.$el = $(file.previewElement)

  handleRemove: (file) =>
    @options.maxFiles += 1 if file.existing and @options.maxFiles?
    @$el.removeClass('dz-max-files-reached')

  handleError: (file) =>
    file.$el.removeClass('dz-processing')

  handleSuccess: (file, resp) =>
    image = new Image()

    image.onload = ->
      file.$el.removeClass('dz-processing')
      file.$el.find('[data-dz-thumbnail]').css(backgroundImage: "url(#{resp.url})")

    image.src = resp.url

  reset: ->
    @removeAllFiles()

  # Dropzone doesn't support addition of existing files
  # see https://github.com/enyo/dropzone/wiki/FAQ#how-to-show-files-already-stored-on-server
  setFiles: (files) ->
    for file in files
      mock = type: 'file', accepted: true, existing: true

      @emit('addedfile', mock)
      @emit('success', mock, url: file.url)
      @emit('complete', mock)
      @emit('thumbnail', mock, file.url)
      @files.push(mock)

    @options.maxFiles -= files.length if @options.maxFiles?
    @$el.addClass('dz-max-files-reached') if @options.maxFiles is 0
