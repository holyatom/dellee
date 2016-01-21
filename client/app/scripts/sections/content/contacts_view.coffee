config = require('config')
React = require('react')
Сomponent = require('app/base/component')
{ Content } = require('app/components')


module.exports = class ContactsView extends Сomponent
  title: -> 'Dellee • Контакты'

  render: ->
    <Content>
      <div className="container">
        <h2>Контакты</h2>
        <p>
          Есть вопросы или пожелания? Напишите нам на <a href={"mailto:#{config.contacts.email}"}>{config.contacts.email}</a> и мы ответим Вам быстрее, чем Вы успеете произнести Dellee!
        </p>
      </div>
    </Content>
