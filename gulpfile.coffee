_ = require('lodash')
pkg = require('./package.json')

fs = require('fs')
gulp = require('gulp')
gulpSequence = require('gulp-sequence')

browserify = require('browserify')
aliasify = require('aliasify')

stylus = require('gulp-stylus')
nib = require('nib')

cssnano = require('gulp-cssnano')
cssurlify = require('gulp-css-decache')
uglify = require('gulp-uglify')

gzip = require('gulp-gzip')
del = require('del')
rev = require('gulp-rev')

streamify = require('gulp-streamify')
source = require('vinyl-source-stream')
rename = require('gulp-rename')

symlink = require('gulp-symlink')
{ exec } = require('child_process')
fontello = require('./lib/fontello')

watch = require('gulp-watch')

log = require('./lib/logger').bind(logPrefix: '[gulp]')


MINIFIED_NAME = suffix: '.min'

PUBLIC_DIR = './public'
PUBLIC_ASSETS = "#{PUBLIC_DIR}/assets"
PUBLIC_ASSETS_TEMP = "#{PUBLIC_DIR}/assets_temp"
FONTS_DIR = "#{PUBLIC_DIR}/fonts"

SOURCE_FOLDER = './.source'

APP_LOCATION = "#{__dirname}/client/app"
ADMIN_LOCATION = "#{__dirname}/client/admin"

APP_VENDOR = [
  'react'
  'react/lib/ReactLink'
  'react-dom'
]

ADMIN_VENDOR = [
  'react'
  'react/lib/ReactLink'
  'react-dom'
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

  bundle = bundle.bundle()
    .on('error', (err) ->
      errorReport(err)
      @emit('end')
    )
    .pipe(source(opts.output))
    .pipe(gulp.dest(PUBLIC_ASSETS))

compileJsBundle = (opts) ->
  opts = _.extend(
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
    .on('error', (err) ->
      errorReport(err)
      @emit('end')
    )
    .pipe(source(opts.output))
    .pipe(gulp.dest(PUBLIC_ASSETS))

compileCss = (opts) ->
  opts = _.extend(
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
    .on('error', (err) ->
      errorReport(err)
      @emit('end')
    )
    .pipe(rename(opts.output))
    .pipe(gulp.dest(PUBLIC_ASSETS))

runNodeJs = (opts) ->
  opts = _.extend(
    file: 'index.js'
    skipWatch: false
    envVariables: {}
  , opts)

  command = ''
  variables = ("#{key}=#{value}" for key, value of opts.envVariables)

  command += variables.join(' ') if variables.length
  command += if opts.skipWatch then ' node' else ' nodemon'
  command += " #{opts.file}"

  runner = exec(command)
  proxy(runner)


# ===============================================================
# TASKS
# ===============================================================

gulp.task 'symlink', ->
  createSymlink(key, path) for key, path of SYMLINKS

gulp.task 'fontello', ->
  fontello.open(
    source: SOURCE_FOLDER
    dest: "#{FONTS_DIR}/fontello"
    styles: "#{APP_LOCATION}/stylesheets/vendor"
  )

gulp.task 'mocha', (done) ->
  runner = exec('env NODE_ENV=test mocha', done)
  proxy(runner)

gulp.task 'remove:assets_temp', (done) ->
  del([PUBLIC_ASSETS_TEMP], done)

gulp.task 'remove:assets', (done) ->
  del([PUBLIC_ASSETS, PUBLIC_ASSETS_TEMP], done)


# ===============================================================
# SCRIPTS
# ===============================================================

gulp.task 'script:create_admin:dev', -> runNodeJs(file: 'scripts/create_admin.js', skipWatch: true)
gulp.task 'script:create_admin:staging', -> runNodeJs(file: 'scripts/create_admin.js', skipWatch: true, envVariables: { NODE_ENV: 'staging' })
gulp.task 'script:create_admin:prod', -> runNodeJs(file: 'scripts/create_admin.js', skipWatch: true, envVariables: { NODE_ENV: 'production' })


# ===============================================================
# DEVELOPMENT
# ===============================================================

gulp.task 'worker:dev', ->
  runNodeJs(file: 'worker.js')

gulp.task 'server:dev', ->
  runNodeJs()

gulp.task 'js:app', ->
  compileJsBundle(input: "#{APP_LOCATION}/scripts/index.coffee", output: 'app.js', exclude: APP_VENDOR)

gulp.task 'js:app_vendor', ->
  compileJsPackets(packets: APP_VENDOR, output: 'app_vendor.js')

gulp.task 'js:admin', ->
  compileJsBundle(input: "#{ADMIN_LOCATION}/scripts/index.coffee", output: 'admin.js', exclude: ADMIN_VENDOR)

gulp.task 'js:admin_vendor', ->
  compileJsPackets(packets: ADMIN_VENDOR, output: 'admin_vendor.js')

gulp.task('js', ['js:app', 'js:app_vendor', 'js:admin', 'js:admin_vendor'])

gulp.task 'css:app', ->
  compileCss(
    input: "#{APP_LOCATION}/stylesheets/index.styl"
    output: 'app.css'
    paths: ["#{APP_LOCATION}/scripts"]
  )

gulp.task 'css:admin', ->
  compileCss(
    input: "#{ADMIN_LOCATION}/stylesheets/index.styl"
    output: 'admin.css'
    paths: ["#{ADMIN_LOCATION}/scripts"]
  )

gulp.task('css', ['css:app', 'css:admin'])

gulp.task 'watch', ->
  watch(['./client/app/stylesheets/**/*.styl', './client/app/scripts/**/*.styl'], watchTask('css:app'))
  watch('./client/app/scripts/**/*.coffee', watchTask('js:app'))

  watch(['./client/admin/stylesheets/**/*.styl', './client/admin/scripts/**/*.styl'], watchTask('css:admin'))
  watch('./client/admin/scripts/**/*.coffee',  watchTask('js:admin'))

gulp.task('dev', gulpSequence(
  'remove:assets'
  [
    'js'
    'css'
  ]
  [
    'watch'
    'server:dev'
  ]
))


# ===============================================================
# STAGING
# ===============================================================

gulp.task 'worker:staging', ->
  runNodeJs(file: 'worker.js', envVariables: { NODE_ENV: 'staging' }, skipWatch: true)

gulp.task 'server:staging', ->
  runNodeJs(envVariables: { NODE_ENV: 'staging' }, skipWatch: true)

gulp.task 'minify:css', ->
  gulp
    .src(["#{PUBLIC_ASSETS}/*.css", "!#{PUBLIC_ASSETS}/*.min.css"])
    .pipe(cssurlify(base: './public', md5: true))
    .pipe(cssnano())
    .pipe(rename(MINIFIED_NAME))
    .pipe(gulp.dest(PUBLIC_ASSETS_TEMP))

gulp.task 'minify:js', ->
  gulp
    .src(["#{PUBLIC_ASSETS}/*.js", "!#{PUBLIC_ASSETS}/*.min.js"])
    .pipe(uglify())
    .pipe(rename(MINIFIED_NAME))
    .pipe(gulp.dest(PUBLIC_ASSETS_TEMP))

gulp.task 'hashify', ->
  gulp
    .src(["#{PUBLIC_ASSETS_TEMP}/*.min.*"])
    .pipe(rev())
    .pipe(gulp.dest(PUBLIC_ASSETS_TEMP))
    .pipe(rev.manifest('hashmap.json'))
    .pipe(gulp.dest(PUBLIC_ASSETS_TEMP))

gulp.task 'compress', ->
  gulp
    .src(["#{PUBLIC_ASSETS_TEMP}/*.min.*"])
    .pipe(gzip())
    .pipe(gulp.dest(PUBLIC_ASSETS_TEMP))

gulp.task 'replace', ->
  gulp
    .src("#{PUBLIC_ASSETS_TEMP}/*")
    .pipe(gulp.dest(PUBLIC_ASSETS))

gulp.task 'clean', (done) ->
  hashmapPath = "#{PUBLIC_ASSETS}/hashmap.json"

  files = [
    PUBLIC_ASSETS_TEMP
    "#{PUBLIC_ASSETS}/*"
    "!#{hashmapPath}"
  ]

  if fs.existsSync(hashmapPath)
    hashmap = fs.readFileSync(hashmapPath, 'utf8')
    hashmap = JSON.parse(hashmap)

    for key, file of hashmap
      files = files.concat([
        "!#{PUBLIC_ASSETS}/#{file}"
        "!#{PUBLIC_ASSETS}/#{file}.gz"
      ])

  del(files, done)

gulp.task('build', gulpSequence(
  'remove:assets_temp'
  [
    'js'
    'css'
  ]
  [
    'minify:js'
    'minify:css'
  ]
  'hashify'
  'compress'
  'replace'
  'clean'
))

gulp.task('staging', gulpSequence('build', 'server:staging'))

# ===============================================================
# PRODUCTION
# ===============================================================

gulp.task 'worker:prod', ->
  runNodeJs(file: 'worker.js', envVariables: { NODE_ENV: 'production' }, skipWatch: true)

gulp.task 'server:prod', ->
  runNodeJs(envVariables: { NODE_ENV: 'production' }, skipWatch: true)

gulp.task('prod', gulpSequence('build', 'server:prod'))
