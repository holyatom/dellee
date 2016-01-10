React = require('react')
Component = require('admin/base/component')
{ TableView, Layout } = require('admin/components')


module.exports = class CustomersListView extends Component
  title: -> 'Список клиентов'

  render: ->
    { data } = @props

    <Layout>
      <header className="page-header">
        <div className="row">
          <h3 className="col-xs-6 col-md-8">Клиенты</h3>
          <div className="col-xs-6 col-md-4 text-right">
            <a href={"#{data.controllerRoot}/create"} className="btn btn-success">Добавить</a>
          </div>
        </div>
      </header>
      <TableView data={@props.data} />
    </Layout>
