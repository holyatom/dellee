React = require('react')
Controller = require('app/base/controller')
SubscriptionsView = require('./subscriptions_view')
CompaniesCollection = require('./companies_collection')


module.exports = class SubscriptionsControlller extends Controller
  index: (ctx, done) ->
    companies = new CompaniesCollection()
    @xhrs.companies = companies.fetch()

    @xhrs.companies.then =>
      data =
        companies: companies.toJSON()

      @renderView(<SubscriptionsView data={data} />, done)

    .fail (xhr) =>
      @renderErrorView(xhr, done)
