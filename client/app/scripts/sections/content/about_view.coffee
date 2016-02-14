config = require('config')
React = require('react')
Сomponent = require('app/base/component')
{ Content } = require('app/components')


module.exports = class AboutView extends Сomponent
  title: -> 'О проекте • Dellee'

  render: ->
    <Content className="p-about">
      <header className="p-a-head">
        <div className="p-a-h-wrapper">
          <h1>Dellee</h1>
          <div className="p-a-h-divider"></div>
          <h2>О проекте</h2>
        </div>
      </header>
      <div className="p-a-top_section">
        <div className="container">
          <h2>Что такое Dellee?</h2>
          <p>Dellee - это сервис, с которым вы получаете возможность просто и удобно следить за всем новым и интересным в вашем городе. На Dellee вы можете найти и подписаться на любимые заведения и просматривать их новости. Более того, вы можете настроить sms или e-mail уведомления и мы будем сообщать вам о последних новостях.</p>
          <h2>Dellee решает следующие знакомые вам проблемы</h2>
          <div className="p-a-problems">
            <ul>
              <li>
                <aside><i className="icon-emoji_sad"></i></aside>
                <main>Рассылки засоряют телефон и почту</main>
              </li>
              <li>
                <aside><i className="icon-emoji_smile"></i></aside>
                <main>С Dellee все новости собраны на вашей персональной странице, а e-mail или sms приходят одним письмом от одного адресанта Dellee. Сотрудники Dellee проверяют содержание новостей, поэтому можете быть уверенны, что <strong>НЕ будете получать неверную информацию и спам!</strong></main>
              </li>
            </ul>
            <ul>
              <li>
                <aside><i className="icon-emoji_sad"></i></aside>
                <main>Не всегда удается узнать об актуальных новостях</main>
              </li>
              <li>
                <aside><i className="icon-emoji_smile"></i></aside>
                <main>C Dellee вы больше не тратите время на проверку страниц в соцсетях или веб-сайтов заведений и не пропускаете выгодные акции и предложения</main>
              </li>
            </ul>
            <ul>
              <li>
                <aside><i className="icon-emoji_sad"></i></aside>
                <main>Отказ от ненужных рассылок зачастую затруднительный и утомительный процесс</main>
              </li>
              <li>
                <aside><i className="icon-emoji_smile"></i></aside>
                <main>C Dellee чтобы перестать получать нежелательные новости просто нажмите “отписаться“</main>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div className="p-a-companies">
        <div className="container">
          <h2>Что Dellee дает компаниям</h2>
          <p>Dellee станет для вашей компании новой и эффективной площадкой для общения с действующими и потенциальными клиентами.</p>
          <ul>
            <li>
              <aside><i className="icon-check"></i></aside>
              <main>У вас появится возможность адресовать большую публику, а не только используяю клиентскую (зачастую устаревшую) базу</main>
            </li>
            <li>
              <aside><i className="icon-check"></i></aside>
              <main>Ваши новости перестанут приниматься за спам, что конечно же укрепит доверие клиентов</main>
            </li>
            <li>
              <aside><i className="icon-check"></i></aside>
              <main>Так как мы избавляем вас от того, что вы будут тратить деньги и время на sms и e-mail</main>
            </li>
            <li>
              <aside><i className="icon-check"></i></aside>
              <main>Также, мы можем помогать вам с составлением текста, оформлением, проверкой</main>
            </li>
          </ul>
        </div>
      </div>
     <div className="p-a-bottom_section">
        <div className="container">
          <h2>Оплата за сервис?</h2>
          <p>Все услуги сервиса всего за <strong>0.00 тг.</strong></p>

          <h2>Наша миссия</h2>
          <p>В Dellee наша команда работает на тем, чтобы разрушить барьер между компаниями и клиентами и сделать ваше общение максимально простым и удобным!</p>
          <p>Мы всегда открыты для предложений по улучшению сервиса <a href={"mailto:#{config.contacts.email}"}>{config.contacts.email}</a>, ведь наша приоритетная цель - это сделать ваше пользование сервисом Dellee наиболее комфортным и эффективным.  И мы верим, что мы можем добиться этого только сотрудничая с вами, нашими пользователями!</p>
          <p>Ну, чего вы ждете? <a href="/#early-access">Подписывайтесь на запуск проекта!</a></p>
        </div>
      </div>
    </Content>
