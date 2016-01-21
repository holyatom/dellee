_ = require('lodash')
needle = require('needle')
fs = require('fs-extra')
open = require('open')
fs = require('fs-extra')
glob = require('glob')
unzip = require('unzip')
log = require('./logger').bind(logPrefix: '[fontello]')


HOST = 'http://fontello.com'
TMP_FOLDER = './.tmp'


dropTmpFolder = ->
  fs.removeSync(TMP_FOLDER)

replaceFontello = (opts, done) ->
  [folderName] = _.last(opts.source.split('/')).split('.')

  log('Extract new zip file...', 'cyan')

  fs.createReadStream(opts.source).pipe(unzip.Extract(path: TMP_FOLDER)).on 'close', ->
    log('Replacing files...', 'cyan')

    unzipped = "#{TMP_FOLDER}/#{folderName}"

    fs.mkdirsSync(opts.dest) unless fs.ensureDirSync(opts.dest)
    fs.copySync("#{unzipped}/font", "#{opts.dest}", clobber: true)
    fs.copySync("#{unzipped}/css/fontello-codes.css", "#{opts.styles}/fontello_codes.css")

    dropTmpFolder()
    done?()

apiRequest = (options, successCallback, errorCallback) ->
  options.host ?= HOST

  requestOptions = multipart: true
  requestOptions.proxy = options.proxy if options.proxy?

  data =
    config:
      file: options.config
      content_type: 'application/json'

  needle.post options.host, data, requestOptions, (error, response, body) ->
    throw error if error
    sessionId = body

    if response.statusCode is 200
      sessionUrl = "#{options.host}/#{sessionId}"
      successCallback? sessionUrl
    else
      errorCallback? response

module.exports =
  open: (opts) ->
    log('Extract old zip file...', 'cyan')

    glob "#{opts.source}/fontello-*.zip", (err, [oldZip]) ->
      [folderName] = _.last(oldZip.split('/')).split('.')

      fs.createReadStream(oldZip).pipe(unzip.Extract(path: TMP_FOLDER)).on 'close', ->
        config = "#{TMP_FOLDER}/#{folderName}/config.json"

        log('Getting session url...', 'cyan')

        apiRequest { config }, (sessionUrl) ->
          open(sessionUrl)
          dropTmpFolder()

          log('Press "ENTER" to start download (save session in browser before downloading)', 'green')

          process.stdin.setRawMode(true)
          process.stdin.resume()
          process.stdin.on 'data', ([keyCode]) ->
            return process.exit() if keyCode is 27
            return unless keyCode is 13

            log('Download new zip file...', 'cyan')

            stream = needle.get "#{sessionUrl}/get", (err, res, body) ->
              # Getting file name
              regexp = /filename=(.*)/gi
              [full, filename] = regexp.exec(res.headers['content-disposition'])

              newZip = "#{opts.source}/#{filename}"

              fs.writeFile newZip, body, ->
                fs.removeSync(oldZip)

                replaceFontello(
                  dest: opts.dest
                  source: newZip
                  styles: opts.styles
                  -> process.exit()
                )
