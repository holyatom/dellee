config = require('config')
React = require('react')
Сomponent = require('app/base/component')
{ Content } = require('app/components')


module.exports = class ContactsView extends Сomponent
  title: -> 'Контакты • Dellee'

  render: ->
    <Content>
      <div className="container">
        <h1>Контакты</h1>
        <p>
          Есть вопросы или пожелания? Напишите нам на <a href={"mailto:#{config.contacts.email}"}>{config.contacts.email}</a> и мы ответим Вам быстрее, чем Вы успеете произнести Dellee!
        </p>
      </div>
    </Content>
