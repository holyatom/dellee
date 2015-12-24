require('./dependencies')
require('./modules/vent')
router = require('./router')
log = require('lib/logger')


router.run()
log('initialized')
