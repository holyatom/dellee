require('./dependencies')
require('./modules/vent')
require('./modules/social')
require('./modules/scroll')
require('./modules/analytics')

Router = require('./router')
log = require('lib/logger')


router = new Router()
router.run()
log('initialized')
