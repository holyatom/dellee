config = require('config')
fs = require('lib/fs')


pathExcludes = []

if config.env is 'production'
  pathExcludes = [
    "#{__dirname}/public/auth.coffee"
    "#{__dirname}/public/companies.coffee"
    "#{__dirname}/public/company_followers.coffee"
    "#{__dirname}/public/customers.coffee"
    "#{__dirname}/public/verifications.coffee"
  ]

module.exports = fs.loadDir(__dirname, { flat: true, pathExcludes })
