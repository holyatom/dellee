React = require('react')
Component = require('admin/base/component')
Layout = require('admin/components/layout')
TableView = require('admin/components/table_view')


module.exports = class CustomersListView extends Component
  title: -> 'Список клиентов'

  render: ->
    { data } = @props

    <Layout>
      <header className="page-header">
        <div className="row">
          <h3 className="col-xs-6 col-md-8">Клиенты</h3>
          <div className="col-xs-6 col-md-4 text-right"></div>
        </div>
      </header>
      <TableView data={@props.data} readonly />
    </Layout>
