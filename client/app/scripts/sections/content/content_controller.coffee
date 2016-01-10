React = require('react')
Controller = require('app/base/controller')
AboutView = require('./about_view')
TermsView = require('./terms_view')
ContactsView = require('./contacts_view')


module.exports = class ContentControlller extends Controller
  about: (ctx, done) ->
    @renderView(<AboutView />, done)

  terms: (ctx, done) ->
    @renderView(<TermsView />, done)

  contacts: (ctx, done) ->
    @renderView(<ContactsView />, done)
