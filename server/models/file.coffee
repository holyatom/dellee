_ = require('lodash')
mongoose = require('mongoose')
v = require('lib/validators')
cdn = require('lib/cdn')
fs = require('fs')
Schema = require('../base/schema')


schema = Schema(
  url:
    type: String
    required: v.required()

  file_type:
    type: String
    required: v.required()
    enum: v.enum([
      'images/shops'
    ])

  mime_type:
    type: String
    required: v.required()
    enum: v.enum([
      'image/jpeg'
      'image/png'
      'image/gif'
    ])

  created:
    type: Date
    required: v.required()
)

File = mongoose.model('File', schema)

File.getExtention = (fileType) ->
  return '.jpg' if fileType is 'image/jpeg'
  fileType.split('/')[1]

File.getMimeType = (extention) ->
  extention = extention.replace('.', '')
  return 'image/jpeg' if extention is 'jpg'
  "image/#{extention}"

File.upload = (fileType, mimeType, stream, filename, cb) ->
  mimeType = mimeType.toLowerCase()
  mimeType = 'image/jpeg' if mimeType is 'image/jpg'
  ext =  if _.startsWith(mimeType, 'image/') then 'jpg' else File.getExtention(mimeType)

  cdn.getWriteStream fileType, ext, (err, cdnObj) =>
    data =
      url: cdnObj.relativeUrl
      name: filename
      size: 0
      file_type: fileType
      mime_type: mimeType
      created: new Date()

    stream.on('data', (chunk) -> data.size += chunk.length)
    stream.on('end', File.finishUpload.bind(null, data, cdnObj, cb))
    stream.pipe(cdnObj.stream)

File.finishUpload = (data, cdnObj, cb) ->
  fileDoc = new File(data)
  fileDoc.save (err, model) ->
    model.url = cdnObj.url unless err
    cb(err, model)

File.deleteByUrl = (url, callback) ->
  File.findOne(url: url).exec (err, fileDoc) ->
    return callback(err) if err
    return callback() unless fileDoc

    File.remove(_id: fileDoc._id, callback)
    fs.unlink(cdn.getPathByUrl(url))

module.exports = File
