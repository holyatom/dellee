React = require('react')
Сomponent = require('app/base/component')
{ Content } = require('app/components')


module.exports = class AboutView extends Сomponent
  title: -> 'Dellee • О проекте'

  render: ->
    <Content>
      <div className="container">
        <h2>О проекте</h2>
      </div>
    </Content>
