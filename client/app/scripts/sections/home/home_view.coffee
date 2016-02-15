$ = require('jquery')
React = require('react')
Form = require('app/base/form')
{ Footer, Header } = require('app/components')
vent = require('app/modules/vent')


module.exports = class HomeView extends Form
  title: -> 'Dellee • Личный Менеджер Подписок'

  initState: ->
    model: {}
    success: false
    error: false
    focused: false

  componentDidMount: ->
    @$emailInput = $('#email-input')

  handleSubmit: (event) =>
    return if @state.isLocked

    event.preventDefault()
    @trigger('save', @state.model)

  scrollToCompanyRegistration: =>
    vent.trigger('scroll', target: '#register-company', duration: 500)

  scrollToSubscribeForm: =>
    vent.trigger('scroll', {target: '#early-access', duration: 500}, => @$emailInput.focus())

  render: ->
    <div className="layout p-home">
      <div className="l-wrapper">
        <section className="p-h-top">
          <div className="container">
            <a href="/">
              <h1 className="ui-logo">Dellee<span className="ui-l-beta_label"></span></h1>
            </a>
            <h2>Dellee</h2>
            <h3>Будь в курсе акций и новостей любимых заведений твоего города</h3>
            <div className="p-h-t-divider"></div>
            <div className="p-h-t-link">
              <span className="ui-btn ui-btn_default ui-btn_large" onClick={@scrollToSubscribeForm}>подпишись на запуск</span>
            </div>
            <div className="p-h-t-arrow">
              <button className="ui-btn" onClick={@scrollToCompanyRegistration}>
                <span>компаниям</span>
                <i className="icon-arrowdown"></i>
              </button>
            </div>
          </div>
        </section>
        <section className="p-h-benefits">
          <div className="container">
            <h2>Что такое Dellee</h2>
            <h3>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal</h3>
            <ul className="p-h-benefits_list">
              <li>
                <figure><i className="icon-data_storage"></i></figure>
                <h3>Единая база</h3>
                <p>
                  Новости любимых заведений собраны и доступны в одном сервисе
                </p>
              </li>
              <li>
                <figure><i className="icon-check_form"></i></figure>
                <h3>Управление подписками</h3>
                <p>
                  Подписывайся/отписывайся одним кликом в любое время
                </p>
              </li>
              <li>
                <figure><i className="icon-mail_phone"></i></figure>
                <h3>E-mail и SMS уведомления</h3>
                <p>
                  Выбирай удобный тебе способ оповещений
                </p>
              </li>
              <li>
                <figure><i className="icon-lock"></i></figure>
                <h3>Приватность</h3>
                <p>
                  Компании не имеют никакой информации о подписчиках включая контактные данные
                </p>
              </li>
            </ul>
            <div className="p-h-b-link">
              <a href="/about" className="ui-btn ui-btn_default ui-btn_large">подробнее о проекте</a>
            </div>
          </div>
        </section>
        <section id="early-access" className="p-h-early_access">
          <div className="container">
            <label htmlFor="email-input"><h2>Ранний доступ</h2></label>
            <div className="p-h-ea-message">
              Приложение находится на стадии разработки. Оставь свой e-mail и мы уведомим тебя о запуске!
            </div>
            <form className={@cx('p-h-ea-form', success: @state.success)} onSubmit={@handleSubmit}>
              <div className={@cx('ui-form_group', focused: @state.focused)}>
                <input id="email-input" onFocus={=> @setState(focused: true)} onBlur={=> @setState(focused: false)} valueLink={@stateLink('model.email')} type="text" name="email" className="ui-input ui-input_large" placeholder="введи свой e-mail" />
                <button type="submit" className="ui-btn ui-btn_primary ui-btn_large" disabled={@state.isLocked}>Сообщить о запуске</button>

                <div className="p-h-ea-success">
                  <span>
                    <i className="ui-iconbox-success"><span className="icon-check"></span></i>
                    Вы успешно подписаны на запуск!
                  </span>
                </div>
              </div>

              {
                if @state.error
                  <div className="ui-help_block ui-help_block_error">{ @state.error }</div>
              }
            </form>
            <div className="p-h-share">
              Расскажи о <strong>Dellee</strong> своим друзьям
              <span className="p-h-s-links">
                <span className="ui-iconbox-circle ui-iconbox-circle_facebook" onClick={=> @trigger('share', 'facebook')}><i className="icon-facebook"></i></span>
                <span className="ui-iconbox-circle ui-iconbox-circle_vk" onClick={=> @trigger('share', 'vk')}><i className="icon-vk"></i></span>
                <span className="ui-iconbox-circle ui-iconbox-circle_twitter" onClick={=> @trigger('share', 'twitter')}><i className="icon-twitter"></i></span>
              </span>
            </div>
          </div>
        </section>
        <section className="p-h-register_company" id="register-company">
          <div className="container">
            <figure>
              <i className="icon-agreement"></i>
            </figure>
            <h2>Бесплатная Регистрация Компаний</h2>
            <h3>Мы предоставляем всем компаниям бесплатный аккаунт для оповещения пользователей о новостях и событиях</h3>
            <div className="p-h-rc-link">
              <a target="_self" href="/admin/register-company" className="ui-btn ui-btn_large">регистрация компании</a>
            </div>
            <div className="p-h-rc-help_message">
              Хотите связаться с нами лично? Перейдите на <a href="/contacts">страницу контактов</a>
            </div>
          </div>
          <Footer />
        </section>
      </div>
    </div>
