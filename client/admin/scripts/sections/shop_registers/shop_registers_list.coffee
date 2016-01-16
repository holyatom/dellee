React = require('react')
Component = require('admin/base/component')
{ TableView, Layout } = require('admin/components')


module.exports = class ShopRegistersListView extends Component
  title: -> 'Список заявок магазинов'

  render: ->
    { data } = @props

    <Layout>
      <ul className="breadcrumb">
        <li><a href="/admin">Главная</a></li>
        <li className="active">Заявки магазинов</li>
      </ul>
      <header className="page-header">
        <h3>Заявки магазинов</h3>
      </header>
      <TableView data={@props.data} />
    </Layout>
