React = require('react')
Component = require('admin/base/component')
{ TableView, Layout } = require('admin/components')


module.exports = class CompanyApplicationListView extends Component
  title: -> 'Список заявок компаний'

  render: ->
    { data } = @props

    <Layout>
      <ul className="breadcrumb">
        <li><a href="/admin">Главная</a></li>
        <li className="active">Заявки компаний</li>
      </ul>
      <header className="page-header">
        <h3>Заявки компаний</h3>
      </header>
      <TableView data={@props.data} />
    </Layout>
