React = require('react')
Component = require('../base/component')
Layout = require('./components/layout')
TableView = require('./components/table_view')


module.exports = class ShopsListView extends Component
  title: -> 'Список магазинов'

  render: ->
    { data } = @props

    <Layout>
      <header className="page-header">
        <div className="row">
          <h3 className="col-xs-6 col-md-8">Магазины</h3>
          <div className="col-xs-6 col-md-4 text-right">
            <a href={"#{data.controllerRoot}/create"} className="btn btn-success">Добавить</a>
          </div>
        </div>
      </header>
      <TableView data={@props.data} />
    </Layout>