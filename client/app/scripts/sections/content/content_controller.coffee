React = require('react')
Controller = require('app/base/controller')
AboutView = require('./about_view')
TermsView = require('./terms_view')
PrivacyView = require('./privacy_view')
ContactsView = require('./contacts_view')
analytics = require('app/modules/analytics')


module.exports = class ContentControlller extends Controller
  about: (ctx, done) ->
    @renderView(<AboutView />, done)

  terms: (ctx, done) ->
    @renderView(<TermsView />, done)

  privacy: (ctx, done) ->
    data =
      analyticsEnabled: not analytics.isDisabled()

    @renderView(<PrivacyView data={data} onDisableAnalytics={@disableAnalytics} />, done)

  contacts: (ctx, done) ->
    @renderView(<ContactsView />, done)

  disableAnalytics: (val) =>
    analytics.disable(val)
    @view.setState(analyticsEnabled: not val)
