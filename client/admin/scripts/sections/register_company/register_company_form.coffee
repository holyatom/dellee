React = require('react')
{ ModelForm, Layout, FormStatus, FileUploader } = require('admin/components')


module.exports = class RegisterCompanyView extends ModelForm
  title: -> 'Dellee • Регистрация компании'

  render: ->
    <Layout className="p-register_company">
      <header className="page-header">
        <h3>Регистрация компании</h3>
      </header>
      <div className="well">
        {
          if @state.success
            <div>
              <h4 className="text-success"><i className="fa fa-hand-peace-o"></i> Успех!</h4>
              <p>
                Ваша заявка на регистрацияю компании успешно отправлена! Мы свяжемся с Вами в теченнии  <strong>5 рабочих дней</strong>.
              </p>
              <p>
                Напоминаем, что аккаунт компании будет открыт после запуска проекта, о чем мы уведомим Вас по e-mail.
              </p>
              <p className="text-muted">
                Хорошего вам дня! <i className="fa fa-smile-o"></i>
              </p>
            </div>
          else
            <form ref="form" className="form-horizontal" onSubmit={@handleSubmit}>
              <fieldset>
                <div className="form-group">
                  <label htmlFor="inputName" className="col-md-3 control-label">Название компании*</label>
                  <div className="col-md-9">
                    <input name="shop_name" valueLink={@stateLink('model.shop_name')} type="text" className="form-control" id="inputName" placeholder="Dellee" />
                    <div className="help-block with-errors"></div>
                  </div>
                </div>
                <div className="form-group">
                  <label htmlFor="inputPerson" className="col-md-3 control-label">Контактное лицо*</label>
                  <div className="col-md-9">
                    <div className="form-double">
                      <div className="form-group">
                        <input name="person.name" valueLink={@stateLink('model.person.name')} type="text" className="form-control" id="inputPerson" placeholder="Имя" />
                        <div className="help-block with-errors"></div>
                      </div>
                      <div className="form-group">
                        <input name="person.surname" valueLink={@stateLink('model.person.surname')} type="text" className="form-control" placeholder="Фамилия" />
                      </div>
                    </div>
                  </div>
                </div>
                <div className="form-group">
                  <label htmlFor="inputEmail" className="col-md-3 control-label">E-mail*</label>
                  <div className="col-md-9">
                    <input name="contacts.email" valueLink={@stateLink('model.contacts.email')} type="text" className="form-control" id="inputEmail" placeholder="shop@mail.com" />
                    <div className="help-block with-errors"></div>
                  </div>
                </div>
                <div className="form-group">
                  <label htmlFor="inputPhonenumber" className="col-md-3 control-label">Номер телефона</label>
                  <div className="col-md-9">
                    <input name="contacts.phonenumber" valueLink={@stateLink('model.contacts.phonenumber')} type="text" className="form-control" id="inputPhonenumber" placeholder="+77XX XXX XXXX" />
                    <div className="help-block with-errors"></div>
                  </div>
                </div>
                <div className="form-group">
                  <label htmlFor="inputAdditional" className="col-md-3 control-label">Дополнительно</label>
                  <div className="col-md-9">
                    <textarea name="additional" rows="5" valueLink={@stateLink('model.additional')} type="text" className="form-control" id="inputAdditional" />
                    <span className="help-block">Здесь Вы можете указать дополнительные данные</span>
                  </div>
                </div>
                <FormStatus {...@state} />
                <div className="form-buttons">
                  <button type="submit" className="btn btn-primary" disabled={@state.isLocked}>Регистрация</button>
                </div>
              </fieldset>
            </form>
        }
      </div>
    </Layout>
