fs = require('fs')
config = require('config')
Busboy = require('busboy')
AdminController = require('server/base/admin_controller')
File = require('server/models/file')


class FilesController extends AdminController
  logPrefix: '[admin files controller]'
  urlPrefix: '/files'

  Model: File

  actions: ['create']

  allowedTypes: File.schema.path('file_type').enumValues
  mimeTypes: File.schema.path('mime_type').enumValues

  create: (req, res, next) ->
    fileType = req.query.file_type

    unless fileType
      return @error(res, file_type: 'required')
    unless fileType in @allowedTypes
      return @error(res, file_type: 'bad_file_type')
    unless req.is('multipart/form-data')
      return @error(res, content_type: 'invalid_value')

    busboy = new Busboy(headers: req.headers)
    created = false

    busboy.on 'file', (fieldname, file, filename, encoding, mimetype) =>
      return unless fieldname is 'file'

      created = true
      unless mimetype in @mimeTypes
        @error(res, mime_type: 'invalid_value')
        return busboy.end()

      @Model.upload fileType, mimetype, file, filename, (err, model) ->
        throw err if err
        res.json(model)

    busboy.on('finish', => @error(res, file: 'required') unless created)
    req.pipe(busboy)

  FilesController::create.type = 'post'


module.exports = new FilesController()
