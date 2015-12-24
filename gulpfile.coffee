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
log = require('lib/logger').bind(logPrefix: 'gulp')


PUBLIC_ASSETS = './public/assets'

APP_VENDOR = [
  'jquery'
  'backbone'
  'classnames'
  'lodash'
  'page'
  'react'
  'react/lib/ReactLink'
  'react-dom'
]

ADMIN_VENDOR = [
  'jquery'
  'backbone'
  'classnames'
  'lodash'
  'page'
  'react'
  'react/lib/ReactLink'
  'react-dom'
]

SYMLINKS =
  'config': './config > node_modules'
  'lib': './lib > node_modules'

errorReport = (err) ->
  log(err.message, 'red bold')

createSymlink = (key, path) ->
  [src, target] = path.split('>')
  gulp
    .src(src.trim())
    .pipe(symlink("#{target.trim()}/#{key}", force: true))

proxy = (runner, callback) ->
  runner.stdout.pipe(process.stdout, end: false)
  runner.stderr.pipe(process.stderr, end: false)
  runner.on('exit', (status) ->
    if status is 0
      callback?()
    else
      process.exit(status)
  )

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
  , opts)

  task = gulp
    .src(opts.input)
    .pipe(stylus(
      'paths': ["#{__dirname}/node_modules"]
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

startServer = (opts) ->
  opts = _.extend(
    skipWatch: false
    envVariables: {}
  , opts)

  command = ''
  variables = ("#{key}=#{value}" for key, value of opts.variables)

  command += variables.join(' ') if variables.length
  command += if opts.skipWatch then 'node' else 'nodemon'
  command += ' index.js'

  runner = exec(command)
  proxy(runner)

gulp.task 'symlink', ->
  createSymlink(key, path) for key, path of SYMLINKS

# ===============================================================
# DEVELOPMENT
# ===============================================================

gulp.task 'server:dev', ->
  startServer()

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
  compileCss(input: './client/app/stylesheets/index.styl', output: 'app.css')

gulp.task 'css:admin', ->
  compileCss(input: './client/admin/stylesheets/index.styl', output: 'admin.css')

gulp.task('css', ['css:app', 'css:admin'])

gulp.task 'watch', ->
  gulp.watch('./client/app/stylesheets/**/*.styl', ['css:app'])
  gulp.watch('./client/app/scripts/**/*.coffee', ['js:app'])

  gulp.watch('./client/admin/stylesheets/**/*.styl', ['css:admin'])
  gulp.watch('./client/admin/scripts/**/*.coffee', ['js:admin'])

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
#   startServer(
#     skipWatch: true
#     envVariables:
#       NODE_ENV: 'production'
#   )

# gulp.task('assets:min', ['js:min', 'css:min'])
# gulp.task('prod', ['server:prod', 'assets:min'])
