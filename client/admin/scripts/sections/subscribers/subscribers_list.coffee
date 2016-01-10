React = require('react')
Component = require('admin/base/component')
{ TableView, Layout } = require('admin/components')


module.exports = class SubscribersView extends Component
  title: -> 'Список подписчиков'

  render: ->
    { data } = @props

    <Layout>
      <header className="page-header">
        <div className="row">
          <h3 className="col-xs-6 col-md-8">Подписчики на старт проекта</h3>
          <div className="col-xs-6 col-md-4 text-right"></div>
        </div>
      </header>
      <TableView readonly data={@props.data} />
    </Layout>
