React = require('react')
Form = require('app/base/form')
{ Footer } = require('app/components')
vent = require('app/modules/vent')


module.exports = class HomeView extends Form
  title: -> 'Dellee • Первый мессенджер акций'

  initState: ->
    model: {}
    success: false
    error: false
    focused: false

  handleSubmit: (event) =>
    return if @state.isLocked

    event.preventDefault()
    @trigger('save', @state.model)

  scrollToCreateShop: =>
    vent.trigger('scroll', target: '#shop-create', duration: 500)

  scrollToSubscribeForm: =>
    vent.trigger('scroll', target: '#early-access', duration: 500)

  render: ->
    <div className="layout p-home">
      <div className="l-wrapper">
        <section className="p-h-top">
          <div className="container">
            <a href="/">
              <h1 className="ui-logo">Dellee<span className="ui-l-beta_label"></span></h1>
            </a>
            <h2>Первый Мессенджер Акций</h2>
            <h3>узнавай первым о скидках и акциях в любимых заведениях</h3>
            <div className="p-h-t-divider"></div>
            <div className="p-h-t-link">
              <span className="ui-btn ui-btn_default ui-btn_large" onClick={@scrollToSubscribeForm}>подписаться на запуск</span>
            </div>
            <div className="p-h-t-arrow">
              <button className="ui-btn" onClick={@scrollToCreateShop}>
                <span>заведениям</span>
                <i className="icon-arrowdown"></i>
              </button>
            </div>
          </div>
        </section>
        <section className="p-h-benefits">
          <div className="container">
            <h2>Наши преимущества</h2>
            <ul className="p-h-benefits_list">
              <li>
                <figure><i className="icon-check_form"></i></figure>
                <h3>Подписывайся одним кликом</h3>
                <p>
                  It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.
                </p>
              </li>
              <li>
                <figure><i className="icon-lock"></i></figure>
                <h3>Конфиденциальность</h3>
                <p>
                  It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.
                </p>
              </li>
              <li>
                <figure><i className="icon-mail_phone"></i></figure>
                <h3>Уведомления</h3>
                <p>
                  It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.
                </p>
              </li>
              <li>
                <figure><i className="icon-data_storage"></i></figure>
                <h3>Единая база</h3>
                <p>
                  It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.
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
            <h2>Ранний доступ</h2>
            <div className="ui-alert ui-alert_info">
              <span className="ui-a-icon">
                <i className="icon-info"></i>
              </span>
              Приложение находится на стадии разработки, но вы можете оставить нам свой e-mail адрес и мы уведомим вас о запуске
            </div>
            <form className={@cx('p-h-ea-form', success: @state.success)} onSubmit={@handleSubmit}>
              <div className={@cx('ui-form_group', focused: @state.focused)}>
                <input onFocus={=> @setState(focused: true)} onBlur={=> @setState(focused: false)} valueLink={@stateLink('model.email')} type="text" name="email" className="ui-form_control ui-form_control_large" placeholder="введи свой e-mail" />
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
                <span className="ui-iconbox-circle ui-iconbox-circle_vk" onClick={=> @trigger('share', 'vk')}><i className="icon-vk"></i></span>
                <span className="ui-iconbox-circle ui-iconbox-circle_twitter" onClick={=> @trigger('share', 'twitter')}><i className="icon-twitter"></i></span>
              </span>
            </div>
          </div>
        </section>
        <section className="p-h-create_shop" id="shop-create">
          <div className="container">
            <figure>
              <i className="icon-agreement"></i>
            </figure>
            <h2>Используйте Dellee бесплатно в своем заведении</h2>
            <h3>Мы предоставляем всем заведениям бесплатный доступ в панель управления для оповещения своих клиентов о акциях и событиях. Перейдите по ссылке ниже для создания профиля.</h3>
            <div className="p-h-cs-link">
              <a target="_self" href="/admin/apply-account" className="ui-btn ui-btn_large">создать аккаунт заведения</a>
            </div>
            <div className="p-h-cs-help_message">
              Хотите связаться с нами лично? Перейдите на <a href="/contacts">страницу контактов</a>
            </div>
          </div>
          <Footer />
        </section>
      </div>
    </div>
