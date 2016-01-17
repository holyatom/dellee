React = require('react')
Component = require('admin/base/component')
{ TableView, Layout } = require('admin/components')


module.exports = class ShopApplicationListView extends Component
  title: -> 'Список заявок заведений'

  render: ->
    { data } = @props

    <Layout>
      <ul className="breadcrumb">
        <li><a href="/admin">Главная</a></li>
        <li className="active">Заявки заведений</li>
      </ul>
      <header className="page-header">
        <h3>Заявки заведений</h3>
      </header>
      <TableView data={@props.data} />
    </Layout>
