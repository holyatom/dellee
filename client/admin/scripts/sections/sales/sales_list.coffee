React = require('react')
Component = require('admin/base/component')
{ TableView, Layout } = require('admin/components')


module.exports = class SalesListView extends Component
  title: -> 'Список акций'

  render: ->
    { data } = @props

    <Layout>
      <ul className="breadcrumb">
        <li><a href="/admin">Главная</a></li>
        <li className="active">Акции</li>
      </ul>
      <header className="page-header">
        <div className="row">
          <h3 className="col-xs-6 col-md-8">Акции</h3>
          <div className="col-xs-6 col-md-4 text-right"></div>
        </div>
      </header>
      <TableView data={@props.data} />
    </Layout>
