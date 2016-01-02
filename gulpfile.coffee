_ = require('lodash')
pkg = require('./package.json')
gulp = require('gulp')
stylus = require('gulp-stylus')
minifyCSS = require('gulp-minify-css')
uglify = require('gulp-uglify')
streamify = require('gulp-streamify')
nib = require('nib')
rename = require('gulp-rename')
browserify = require('browserify')
aliasify = require('aliasify')
source = require('vinyl-source-stream')
symlink = require('gulp-symlink')
{ exec } = require('child_process')
log = require('lib/logger').bind(logPrefix: '[gulp]')
fs = require('fs-extra')
glob = require('glob')
unzip = require('unzip')
needle = require('needle')
open = require('open')
fontello = require('lib/fontello')
watch = require('gulp-watch')


PUBLIC_DIR = './public'
PUBLIC_ASSETS = "#{PUBLIC_DIR}/assets"
FONTS_DIR = "#{PUBLIC_DIR}/fonts"

TMP_FOLDER = './.tmp'
SOURCE_FOLDER = './.source'

APP_LOCATION = "#{__dirname}/client/app"

APP_VENDOR = [
  'backbone'
  # 'backbone.localstorage'
  'classnames'
  'lodash'
  'page'
  'react'
  'react/lib/ReactLink'
  'react-dom'
  'jquery'
]

ADMIN_VENDOR = [
  'backbone'
  'backbone.localstorage'
  'bootstrap'
  'classnames'
  'lodash'
  'page'
  'react'
  'react/lib/ReactLink'
  'react-dom'
  'jquery'
]

SYMLINKS =
  'config': './config > node_modules'
  'lib': './lib > node_modules'
  'server': './server > node_modules'
  'admin': './client/admin/scripts > node_modules'
  'app': './client/app/scripts > node_modules'


proxy = (runner, callback) ->
  runner.stdout.pipe(process.stdout, end: false)
  runner.stderr.pipe(process.stderr, end: false)
  runner.on('exit', (status) ->
    if status is 0
      callback?()
    else
      process.exit(status)
  )

errorReport = (err) ->
  log(err.message or err, 'red bold')

dropTmpFolder = ->
  fs.removeSync(TMP_FOLDER)

watchTask = (taskName) ->
  (event) ->
    log("#{_.last(event.path.split('/'))} changed", 'cyan')
    gulp.start(taskName)


# ===============================================================
# HELPERS
# ===============================================================

createSymlink = (key, path) ->
  [src, target] = path.split('>')
  gulp
    .src(src.trim())
    .pipe(symlink("#{target.trim()}/#{key}", force: true))

replaceFontello = (zipFile, done) ->
  [folderName] = _.last(zipFile.split('/')).split('.')

  SOURCE = "#{TMP_FOLDER}/#{folderName}"
  FONT_LOCATION = "#{FONTS_DIR}/fontello"

  unless fs.ensureDirSync(FONT_LOCATION)
    fs.mkdirsSync(FONT_LOCATION)

  log('Extract new zip file...', 'cyan')

  fs.createReadStream(zipFile).pipe(unzip.Extract(path: TMP_FOLDER)).on 'close', ->
    log('Replacing files...', 'cyan')

    fs.copySync("#{SOURCE}/font", "#{FONT_LOCATION}", clobber: true)
    fs.copySync("#{SOURCE}/css/fontello-codes.css", "#{APP_LOCATION}/stylesheets/vendor/fontello_codes.css")
    dropTmpFolder()
    done?()

installFontello = ->
  log('Extract old zip file...', 'cyan')

  glob "#{SOURCE_FOLDER}/fontello-*.zip", (err, [oldZip]) ->
    [folderName] = _.last(oldZip.split('/')).split('.')

    fs.createReadStream(oldZip).pipe(unzip.Extract(path: TMP_FOLDER)).on 'close', ->
      config = "#{TMP_FOLDER}/#{folderName}/config.json"

      log('Getting session url...', 'cyan')

      fontello.apiRequest { config }, (sessionUrl) ->
        open(sessionUrl)
        dropTmpFolder()

        log('Press "ENTER" to start download (save session in browser before downloading)', 'green')

        process.stdin.setRawMode(true)
        process.stdin.resume()
        process.stdin.on 'data', ([keyCode]) ->
          return unless keyCode is 13

          log('Download new zip file...', 'cyan')

          stream = needle.get "#{sessionUrl}/get", (err, res, body) ->
            # Getting file name
            regexp = /filename=(.*)/gi
            [full, filename] = regexp.exec(res.headers['content-disposition'])

            newZip = "#{SOURCE_FOLDER}/#{filename}"

            fs.writeFile(newZip, body, ->
              fs.removeSync(oldZip)
              replaceFontello(newZip, -> process.exit())
            )


# ===============================================================
# COMPILERS
# ===============================================================

compileJsPackets = (opts) ->
  opts = _.extend(
    packets: []
    output: ''
  , opts)

  bundle = browserify()

  bundle.require(packet, expose: packet) for packet in opts.packets
  bundle.transform(global: true, aliasify)

  bundle.bundle()
    .on('error', errorReport)
    .pipe(source(opts.output))
    .pipe(streamify(uglify()))
    .pipe(gulp.dest(PUBLIC_ASSETS))

compileJsBundle = (opts) ->
  opts = _.extend(
    minify: false
    input: ''
    output: ''
    exclude: []
  , opts)

  bundle = browserify(
    entries: [opts.input]
    paths: ['./node_modules']
    extensions: ['.coffee']
  )

  bundle.exclude(packet) for packet in opts.exclude
  bundle.transform(global: true, aliasify)

  bundle = bundle.bundle()
    .on('error', errorReport)
    .pipe(source(opts.output))

  bundle = bundle.pipe(streamify(uglify())) if opts.minify
  bundle.pipe(gulp.dest(PUBLIC_ASSETS))

compileCss = (opts) ->
  opts = _.extend(
    minify: false
    input: ''
    output: ''
    paths: []
  , opts)

  task = gulp
    .src(opts.input)
    .pipe(stylus(
      'paths': ["#{__dirname}/node_modules"].concat(opts.paths)
      'include css': true
      'use': [nib()]
      'urlfunc': 'embedurl'
      'linenos': true
      'define':
        '$version': pkg.version
    ))
    .on('error', errorReport)
    .pipe(rename(opts.output))

  task = task.pipe(minifyCSS()) if opts.minify
  task = task.pipe(gulp.dest(PUBLIC_ASSETS))

runNodeJs = (opts) ->
  opts = _.extend(
    file: 'index.js'
    skipWatch: false
    envVariables: {}
  , opts)

  command = ''
  variables = ("#{key}=#{value}" for key, value of opts.variables)

  command += variables.join(' ') if variables.length
  command += if opts.skipWatch then 'node' else 'nodemon'
  command += " #{opts.file}"

  runner = exec(command)
  proxy(runner)


# ===============================================================
# TASKS
# ===============================================================

gulp.task 'symlink', ->
  createSymlink(key, path) for key, path of SYMLINKS

gulp.task 'fontello', ->
  installFontello()


# ===============================================================
# DEVELOPMENT
# ===============================================================

gulp.task 'worker:dev', ->
  runNodeJs(file: 'worker.js')

gulp.task 'server:dev', ->
  runNodeJs()

gulp.task 'js:app', ->
  compileJsBundle(input: './client/app/scripts/index.coffee', output: 'app.js', exclude: APP_VENDOR)

gulp.task 'js:app_vendor', ->
  compileJsPackets(packets: APP_VENDOR, output: 'app.vendor.js')

gulp.task 'js:admin', ->
  compileJsBundle(input: './client/admin/scripts/index.coffee', output: 'admin.js', exclude: ADMIN_VENDOR)

gulp.task 'js:admin_vendor', ->
  compileJsPackets(packets: ADMIN_VENDOR, output: 'admin.vendor.js')

gulp.task('js', ['js:app', 'js:app_vendor', 'js:admin', 'js:admin_vendor'])

gulp.task 'css:app', ->
  compileCss(
    input: './client/app/stylesheets/index.styl'
    output: 'app.css'
    paths: ["#{APP_LOCATION}/scripts"]
  )

gulp.task 'css:admin', ->
  compileCss(input: './client/admin/stylesheets/index.styl', output: 'admin.css')

gulp.task('css', ['css:app', 'css:admin'])

gulp.task 'watch', ->
  watch(['./client/app/stylesheets/**/*.styl', './client/app/scripts/**/*.styl'], watchTask('css:app'))
  watch('./client/app/scripts/**/*.coffee', watchTask('js:app'))

  watch('./client/admin/stylesheets/**/*.styl', watchTask('css:admin'))
  watch('./client/admin/scripts/**/*.coffee',  watchTask('js:admin'))

gulp.task('assets', ['js', 'css'])
gulp.task('dev', ['server:dev', 'assets', 'watch'])


# ===============================================================
# PRODUCTION
# ===============================================================

# gulp.task 'js:app:min', ->
#   compileAppJs(minify: true)

# gulp.task('js:min', ['js:vendor', 'js:app:min'])

# gulp.task 'css:min', ->
#   compileCss(minify: true)

# gulp.task 'server:prod', ->
#   runNodeJs(
#     skipWatch: true
#     envVariables:
#       NODE_ENV: 'production'
#   )

# gulp.task('assets:min', ['js:min', 'css:min'])
# gulp.task('prod', ['server:prod', 'assets:min'])
