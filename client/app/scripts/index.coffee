require('./dependencies')
require('./modules/vent')
require('./modules/social')

Router = require('./router')
log = require('lib/logger')


router = new Router()
router.run()
log('initialized')
