require('./dependencies')
require('./modules/vent')
require('./modules/session')
require('./modules/profile')
require('./modules/scroll')
require('./modules/modal_loader')
require('./modules/social')

Router = require('./router')
log = require('lib/logger')


router = new Router()
router.run()
log('initialized')
