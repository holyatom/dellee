require('./dependencies')
require('./modules/vent')
require('./modules/session')
require('./modules/profile')
require('./modules/scroll')

Router = require('./router')
log = require('lib/logger')


router = new Router()
router.run()
log('initialized')
