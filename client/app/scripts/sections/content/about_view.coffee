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
          <p><strong>Dellee</strong> - это сервис, с которым вы получаете возможность просто и удобно следить за всем новым и интересным в вашем городе. На Dellee вы можете найти все любимые заведения и просматривать их новости. Более того, вы можете настроить sms или e-mail уведомления, чтобы оставаться в курсе последних новостей.</p>
          <h2>Dellee решает следующие проблемы:</h2>
          <div className="p-a-problems">
            <ul>
              <li>
                <aside><i className="icon-emoji_sad"></i></aside>
                <main>Рассылки засоряют телефон и почту</main>
              </li>
              <li>
                <aside><i className="icon-emoji_smile"></i></aside>
                <main>С Dellee все новости собраны на вашей персональной странице, а e-mail или sms приходят одним письмом от одного адресанта Dellee. Сотрудники Dellee проверяют содержание новостей, поэтому можете быть уверенны, что не будете получать неверную информацию и спам.</main>
              </li>
            </ul>
            <ul>
              <li>
                <aside><i className="icon-emoji_sad"></i></aside>
                <main>Не всегда удается узнать об актуальных новостях</main>
              </li>
              <li>
                <aside><i className="icon-emoji_smile"></i></aside>
                <main>C Dellee вы больше не пропускаете выгодные акции и предложения, при этом не тратите время на проверку страниц в соцсетях или веб-сайтов заведений.</main>
              </li>
            </ul>
            <ul>
              <li>
                <aside><i className="icon-emoji_sad"></i></aside>
                <main>Отказ от ненужных рассылок зачастую затруднительный и утомительный процесс</main>
              </li>
              <li>
                <aside><i className="icon-emoji_smile"></i></aside>
                <main>C Dellee чтобы перестать получать нежелательные новости просто <strong>нажмите “отписаться“.</strong></main>
              </li>
            </ul>
            <ul>
              <li>
                <aside><i className="icon-emoji_sad"></i></aside>
                <main>Не у всех заведений есть оповещения или другие способы связи с клиентами</main>
              </li>
              <li>
                <aside><i className="icon-emoji_smile"></i></aside>
                <main>Мы работаем над тем, чтобы на Dellee вы смогли найти все любимые заведения.</main>
              </li>
            </ul>
            <ul>
              <li>
                <aside><i className="icon-emoji_sad"></i></aside>
                <main>Для получения новостных рассылок нужно оставлять личные данные</main>
              </li>
              <li>
                <aside><i className="icon-emoji_smile"></i></aside>
                <main>На Dellee компании не имеют доступа к какой-либо информации о пользователях. Таким образом мы обеспечиваем вам приватность и конфедициальность личных данных. Также, благодаря этому вы всегда остаетесь на связи даже при изменении контактных данных.</main>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div className="p-a-companies">
        <div className="container">
          <h2>Что Dellee дает компаниям</h2>
          <p>Для компаний это новая площадка для общения с действующими и потенциальными клиентами, благодаря которой:</p>
          <ul>
            <li>
              <aside><i className="icon-check"></i></aside>
              <main>Вы получаете доступ к значительно большей аудитории, чем при использовании клиентской базы, которая зачастую бывает устаревшей;</main>
            </li>
            <li>
              <aside><i className="icon-check"></i></aside>
              <main>Ваши новости доходят до пользователей своевременно, не теряются в куче подобных сообщений и не отправляются в папку “спам“;</main>
            </li>
            <li>
              <aside><i className="icon-check"></i></aside>
              <main>Вы уменьшите затраты на работу с оповещением клиентов, так как мы сами осуществляем sms и e-mail рассылки, а также предлагаем помощь в составлении текста и оформлении новостных сообщений;</main>
            </li>
            <li>
              <aside><i className="icon-check"></i></aside>
              <main>Вы можете общаться с потенциальными клиентами без использования их личных данных, что помогает приобрести и укрепить их доверие;</main>
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
          <p>Мы всегда открыты для предложений по улучшению сервиса (<a href={"mailto:#{config.contacts.email}"}>{config.contacts.email}</a>), ведь наша приоритетная цель - это сделать ваше пользование Dellee наиболее комфортным и эффективным.</p>
          <p>Ну, чего вы ждете? <a href="/#early-access">Подписывайтесь на запуск проекта!</a></p>
        </div>
      </div>
    </Content>
