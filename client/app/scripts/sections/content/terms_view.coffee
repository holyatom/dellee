React = require('react')
Сomponent = require('app/base/component')
{ Content } = require('app/components')


module.exports = class TermsView extends Сomponent
  title: -> 'Dellee • Правила'

  render: ->
    <Content>
      <div className="container">
        <h2>Правила</h2>
      </div>
    </Content>
