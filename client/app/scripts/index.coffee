require('./dependencies')
require('./modules/vent')

Router = require('./router')
log = require('lib/logger')


router = new Router()
router.run()
log('initialized')
