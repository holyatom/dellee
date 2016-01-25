_ = require('lodash')
$ = require('jquery')
Dropzone = require('dropzone')
config = require('config')


defaultOptions =
  # FIXME: change to dellee endpoint - "#{config.api_root}/upload"
  url: "#{config.api_root}/files"
  paramName: 'file'

  dictMaxFilesExceeded: 'Загружено макс. файлов'
  dictInvalidFileType: 'Неверный тип'
  dictFileTooBig: 'Макс. размер'
  dictResponseError: 'Ошибка сервера'
  dictCancelUploadConfirmation: 'Вы уверены что хотите прервать загрузку?'
  dictRemoveFileConfirmation: 'Вы уверены что хотите удалить файл?'

  # headers:
  #   'Cache-Control': '' # remove cache control header
  #   'X-AUTH-TOKEN': profile.get('toke')?.value


module.exports = class Uploader extends Dropzone
  @url: defaultOptions.url
  defaultOptions: _.defaultsDeep(defaultOptions, Dropzone::defaultOptions)

  constructor: ->
    super

    @$el = $(@element)

    @on('addedfile', @handleAdd)
    @on('removedfile', @handleRemove)
    @on('error', @handleError)
    @on('success', @handleSuccess)

  handleAdd: (file) =>
    file.$el = $(file.previewElement)

  handleRemove: (file) =>
    @options.maxFiles += 1 if file.existing and @options.maxFiles?
    @$el.removeClass('dz-max-files-reached')

  handleError: (file, err) =>
    file.$el.removeClass('dz-processing')

  handleSuccess: (file, resp) =>
    image = new Image()
    $thumb = file.$el.find('[data-dz-thumbnail]')
    $link = $thumb.parent()

    if $link.is('a')
      $link.attr('href', resp.url)

    image.onload = ->
      file.$el.removeClass('dz-processing')
      $thumb.css(backgroundImage: "url(#{resp.url})")

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
