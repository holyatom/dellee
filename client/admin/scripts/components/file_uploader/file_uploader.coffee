React = require('react')
fs = require('fs')
Component = require('admin/base/component')
Uploader = require('./uploader')


module.exports = class FileUploader extends Component
  options: ->
    previewsContainer: @refs.preview
    previewTemplate: fs.readFileSync("#{__dirname}/file_preview.html", 'utf8')

  componentDidMount: ->
    @uploader = new Uploader(@refs.dropzone, @options())

  render: ->
    <div className="c-file_uploader">
      <div className="c-fu-dropzone dropzone form-control" ref="dropzone">
        <div className="dz-message" data-dz-message>
          <span>Перетащите файлы сюда</span>
          <small>или просто кликните</small>
        </div>
      </div>
      <div className="c-fu-preview" ref="preview"></div>
    </div>
