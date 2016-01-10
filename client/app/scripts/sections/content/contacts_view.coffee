React = require('react')
Сomponent = require('app/base/component')
{ Content } = require('app/components')


module.exports = class ContactsView extends Сomponent
  title: -> 'Dellee • Контакты'

  render: ->
    <Content>
      <div className="container">
        <h2>Контакты</h2>
      </div>
    </Content>
