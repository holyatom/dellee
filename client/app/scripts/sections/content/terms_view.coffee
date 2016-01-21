config = require('config')
React = require('react')
Сomponent = require('app/base/component')
{ Content } = require('app/components')


module.exports = class TermsView extends Сomponent
  title: -> 'Dellee • Правила сервиса'

  render: ->
    <Content>
      <div className="container">
        <h1>Условия Использования ("Условия")</h1>
        <small>Последнее обновление: 15 января, 2016</small>
        <p>
          Пожалуйста, внимательно ознакомьтесь с Условиями Использования, в соответствии с которыми Вы (“Пользователь”) вправе пользоваться веб-сайтом http://dellee.me (“Сервис”, “веб-сайт”, “сайт”), находящимся под управлением Dellee (“мы”).
        </p>
        <p>
          Данные условия считаются принятыми Вами каждый раз, когда Вы получаете доступ к Сервису и пользуетесь его услугами. Также считается, что Вы проверяете, ознакамливаетесь и соглашаетесь с изменениями, вносимыми нами в данные Условия и <a href="/privacy">Политику Конфиденциальности</a>. Условия Использования распространяются на всех посетителей, пользователей и других лиц, которые получают доступ или используют Сервис.
        </p>
        <p>
          Если Вы не согласны с каким-либо пунктом настоящих Условий, то Вы не можете пользоваться Сервисом.
        </p>
        <h2>Доступ к Сервису</h2>
        <p>Для того, чтобы стать пользователем Dellee (далее «Пользователь»), Вам необходимо зарегистрировать аккаунт, установив логин и пароль, а также пройти верификацию электронной почты.</p>
        <p>Для создания аккаунта Вы соглашаетесь предоставить нам точную, полную и актуальную на момент пользования Сервисом информацию. Невыполнение данного пункта является нарушением Условий, что может привести к немедленному удалению Вашего аккаунта на веб-сайте Dellee.</p>
        <p>Вы несете полную ответственность за сохранение своего пароля, который Вы используете для доступа к Сервису, а также за все действия произведенные под Вашей учетной записью. Пароли могут быть сброшены или приостановлены в любое время при необходимости.</p>
        <p>Вы соглашаетесь не разглашать свой пароль третьим лицам. Вы должны сообщить нам немедленно после того, как Вам станет известно о любом нарушении безопасности или несанкционированного использования Вашей учетной записи.</p>
        <p>Мы не можем гарантировать непрерывную, бесперебойную или безошибочную работу Сервиса. Возможно то, что некоторые функциональности, детали или содержание веб-сайта (“контент”, “материалы”) Dellee будут недоступными (в результате как запланированных, так и внеплановых работ), измененными, временно или перманентно удалены по нашему собственному усмотрению, без предварительного уведомления. Вы соглашаетесь, что мы не несем ответственности перед Вами или третьей стороной за недоступность, изменение или удаление какого-либо функционала или контента веб-сайта.</p>
        <h2>Контент и Коммуникации</h2>
        <p>Мы оставляем за собой право менять формат и контент веб-сайта Dellee.</p>
        <p>Мы не можем и не гарантируем, что контент веб-сайта Сервиса свободен от вирусов или другого компьютерного кода, файлов и программ, созданных для приостановки, уничтожения или ограничения функциональности любого компьютерного программного или аппаратного обеспечения,  а также телекоммуникационного оборудования. Вы ответственны за то, чтобы предпринять необходимые меры для информационной безопасности</p>
        <p>Контент, который предоставляется третьими лицами и включает в себя информацию о ценах, скидках, а также купоны, призы, рекламные объявления, новости и другую аналогичную информацию не находится под управлением Dellee и поэтому использование такого контента находится полностью под Вашей ответственностью. Dellee не несет никакой ответственности за законность, качество и безопасность предоставляемых третьей стороной информации и предложений, а также осуществляемых операций между Вами и третьей стороной, включая продажи и другие сделки. Так как актуальные цены и детали предложений могут отличаться от предоставленной нам третьими лицами, Вам следует подтверждать полученную информацию по контактному телефону третьей стороны.</p>
        <p>Если администрации Dellee станет известно о контенте, нарушающем Условия и/или действующий закон, правила или положения, она может по своему усмотрению удалить такой контент или прекратить использование Сервиса Пользователем, который разместил подобное содержание; однако, администрация не несет ответственности за данное действие. Если Пользователь увидит текст или получит сообщение, содержание которого нарушает данные Условия, он может выслать e-mail на <a href={"mailto:#{config.contacts.email}"}>{config.contacts.email}</a> с подробным описанием данной проблемы.</p>
        <h2>Авторские Права и Ограничения на Использование Веб-сайта</h2>
        <p>Dellee разрешает Вам просматривать и загружать один экземпляр контента, доступного на веб-сайте, в Ваших личных целях, не нарушающих закон и несвязанных с коммерческой деятельностью в соответствии с разрешениями и ограничениями указанными в Условиях Использования, включая соблюдение авторского права и других прав собственности. Вы соглашаетесь не хранить страницы сайта на сервере или других устройствах хранения данных подключенных к сети или создавать электронную базу данных путем систематической загрузки и хранения всех страниц сайта.</p>
        <p>Веб-сайт Сервиса не должен быть использован Пользователем для публикации, распространения и иного использования контента или другого материала, который:</p>
        <ol>
          <li>нарушает Условия Использования;</li>
          <li>нарушает авторские права, торговую марку, коммерческую тайну или другие права на интеллектуальную собственность, нарушает неприкосновенность частной жизни или гласность, а также другие личные права лиц;</li>
          <li>является мошенническим, неправдивым, дискредитирующим, непристойным, угрожающим, оскорбительным, содержащим порнографию, а также схемы финансовых пирамид;</li>
          <li>нарушает действующие законы, нормы и правила, в том числе, без ограничения, защиты прав потребителей, конфиденциальность и торговые законы и правила;</li>
        </ol>
        <p>
          Вы соглашаетесь не осуществлять следующие действия: удаление или изменение каких-либо материалов веб-сайта, любое действие, которое налагает чрезмерную или непропорционально большую нагрузку на инфраструктуру сайта, использование любого интеллектуального анализа данных, роботов, пауков и других автоматизированных устройств, процессов и средств доступа к веб-сайту, публикация нежелательной рекламы, почтовые атаки, рассылка спамов.
        </p>
        <p>
          Вы соглашаетесь не нагружать, проводить обратный инжиниринг, декомпилировать или иными способами мешать работе сайта и сервера, а также использованию Сервера другими Пользователями. Вы также соглашаетесь, что вы не будете вручную проводить мониторинг или копировать материал для несанкционированного использования без предварительного письменного разрешения Dellee. Вы соглашаетесь не использовать Сервис для намеренного или ненамеренного нарушения любого применимого местного, государственного или международное законодательства, регулирования или постановления.
        </p>
        <p>Вы не можете копировать, использовать, загружать, изменять, публиковать, передавать, продавать, лицензировать, воспроизводить, создавать производные работы, распространять, перемещать, удалять или каким-либо образом использовать в коммерческих целях любой материал полностью или частично, прямо или косвенно, без предварительного письменного согласия Dellee и / или его владельца, за исключением разрешенного Условиями или действующим законодательством использования. Если Dellee предоставляет разрешение, вы не можете менять или удалять авторскую атрибуцию, торговую марку или уведомление об авторских правах.</p>
        <p>Содержимое веб-сайта Dellee включая текст, графику, программное обеспечение, фотографии и другие изображения, видео, звук, товарные знаки и логотипы, информацию, текст, элементы дизайна принадлежат нам и защищены законами об авторском праве и товарных знаках.</p>
        <p>Товарные знаки, знаки обслуживания, логотипы и другие знаки (вместе «Знаки»), используемые на данном веб-сайте, принадлежат Dellee и другим. Лицензии или права на использование любых торговых марок, содержащихся на данном веб-сайте никак не предоставляется. Любое использование Знаков, содержащихся на данном веб-сайте запрещено без письменного разрешения владельца Знаков.</p>
        <p>Если Вы полагаете, что на сайт Dellee были загружены, опубликованы или скопированы Ваши работы или товарный знак, защищенные авторским правом, свяжитесь с нами через электронную почту <a href={"mailto:#{config.contacts.email}"}>{config.contacts.email}</a> с подробным описанием проблемы.</p>
        <p>Все права, предоставленные Вам в соответствии с этими Условиями будут немедленно прекращены в случае, если вы нарушаете какое-либо из них.</p>
        <h2>Дополнительная Информация для Организаций</h2>
        <p>Организация может оставить заявку на сайте Сервиса для создания аккаунта и последующего получения услуг предоставляемых Dellee. Проверка производится администрацией Dellee в течении 3 дней.</p>
        <p>Организация несет единоличную ответственность за контент предоставленный нам.</p>
        <p>Организация согласна, что Dellee имеет право на проверку предоставленного контента на соответствие требований данных Условий и действующему законодательству Республики Казахстан. В случае несоответствия, Dellee вправе отказать, приостановить, прекратить оказание услуг. При отказе/приостановке/прекращении оказания услуг по основаниям, предусмотренным Условиями, Сервис не несет ответственности за возможные убытки, понесенные Организацией в связи с таким отказом/приостановкой/прекращением, в том числе за упущенную выгоду</p>
        <p>Контент, предоставленный Организацией не должен содержать:</p>
        <ol>
          <li>названия, логотипы и товарные знаки сторонних компаний без их явно выраженного письменного согласия;</li>
          <li>заведомо ложные, вводящие в заблуждение, неточные или неактуальные данные;</li>
          <li>интересы какой-либо политической партии, политические взгляды или вопросы;</li>
          <li>продвижение религиозных взглядов;</li>
          <li>запросы на донорство органов, а также репродуктивные услуги включая донорство яйцеклеток и суррогатное материнство;</li>
          <li>предложение о продаже или использовании запрещенных наркотиков, а также лекарственных средств, отпускаемых по рецепту, табачных изделий; пищевых добавок, которые Dellee считает небезопасными, оружия, боеприпасов или взрывчатых веществ. Предложения и реклама медицинских услуг, оборудования, лекарственных средств, алкоголя должны соответсвовать действующему законодательству Республики Казахстан;</li>
          <li>шокирующие, сенсационные, неуважительные или чересчур жестокие материалы;</li>
          <li>личные характеристики включая прямое или косвенное упоминание или указание расы, этнического происхождения, религии, убеждений, возраста, сексуальной ориентации или поведения, гендерной идентичности, инвалидности, медицинского состояния, финансового состояния, возраста или имени, персональные контактные данные;</li>
          <li>неработающие целевые страницы, а также страницы, которые не позволяют Пользователю уйти с них;</li>
          <li>ошибки правописания или пунктуации;</li>
          <li>оскорбления, неприличия или ругательства.</li>
          <li>изображения низкого качества.</li>
          <small>Этот список приведен в иллюстративных целях и не является полным.</small>
        </ol>
        <p>Dellee также оставляет за собой право отклонять или удалять контент предоставленный Организациями, который, по обоснованному усмотрению Dellee нарушает наши интересы или способен подорвать нашу конкурентоспособность.</p>
        <p>Для защиты Пользователей Dellee от коммерческой рекламы и навязывания услуг Delee сохраняет за собой право ограничить число электронных писем и смс которые Delee отправляет Пользователям, до уровня, установленного нами по собственному усмотрению. </p>
        <p>Организации несут ответственность за понимание и соблюдение требований всех применимых норм и законов. Несоблюдение может привести к различным последствиям, включая прекращение оказания услуг и удаление аккаунта.</p>
        <p>Организация соглашается не передавать свои права и/или обязанности по настоящим Условиям третьим лицам.</p>
        <h2>Отказ От Ответственности</h2>
        <p>Сайт и контент Dellee предоставляются по принципу "как есть" без каких-либо гарантий. В полной мере, разрешенной законом, Dellee отказывается от всех гарантий, включая гарантии коммерческой выгоды, отсутствия нарушения прав третьих лиц и гарантии пригодности для конкретной цели и не дает никаких гарантий в отношении точности, надежности, полноты и актуальности материала. </p>
        <p>Dellee не делает никаких заявлений или гарантий, что (1) веб-сайт будет отвечать вашим требованиям, что (2) его работа будет бесперебойной, доступной, быстрой, надежной и безошибочной, (3) качество материала будет соответствовать вашим ожиданиям, а также (4) любые ошибки на сайте будут исправлены.</p>
        <p>Если использование Вами сайта или материала Dellee, приводит к необходимости обслуживания или замены оборудования или данных, Dellee также не несет ответственности за эти расходы. </p>
        <h2>Ограничение Ответственности</h2>
        <p>В МАКСИМАЛЬНОЙ СТЕПЕНИ, ДОПУСТИМОЙ В СООТВЕТСТВИИ С ДЕЙСТВУЮЩИМ ЗАКОНОДАТЕЛЬСТВОМ, DELLEE НЕ НЕСЕТ ОТВЕТСТВЕННОСТИ СОГЛАСНО ЛЮБОЙ ТЕОРИИ ПРАВА ЗА СЛУЧАЙНЫЕ, ПРЯМЫЕ, КОСВЕННЫЕ, ДЕЙСТВИТЕЛЬНЫЕ, ПОСЛЕДУЮЩИЕ, СПЕЦИАЛЬНЫЕ, ШТРАФНЫЕ ИЛИ АНАЛОГИЧНЫЕ УБЫТКИ, ВОЗНИКАЮЩИЕ В РЕЗУЛЬТАТЕ ДОСТУПА, ИСПОЛЬЗОВАНИЯ ИЛИ НЕВОЗМОЖНОСТИ ДОСТУПА ИЛИ ИСПОЛЬЗОВАНИЯ ВЕБ-САЙТА, ВКЛЮЧАЯ, БЕЗ ОГРАНИЧЕНИЯ, УБЫТКИ БИЗНЕСА, УПУЩЕННУЮ ВЫГОДУ, ПОТЕРЯННЫЕ НАКОПЛЕНИЯ ИЛИ ДОХОДЫ.ОПИСАННЫЕ ОГРАНИЧЕНИЯ ПРИМЕНЯЮТСЯ ДАЖЕ ЕСЛИ СТОРОНЫ DELLEE БЫЛИ УВЕДОМЛЕНЫ О ВОЗМОЖНОСТИ ТАКОГО УЩЕРБА, ПОТЕРИ ИЛИ РАСХОДОВ.</p>
        <h2>Ссылки на Другие Сайты</h2>
        <p>Контент Сервиса может содержать ссылки на сторонние веб-сайты или услуги, которые не принадлежат или контролируются Dellee. Подобные ссылки служат для того, чтобы предоставить вам доступ к информации, продукции или услугам, которые могут быть полезными или интересными для Вас.</p>
        <p>Dellee не имеет никакого контроля и не несет ответственности за содержание и политику конфиденциальности любых сторонних веб-сайтов или услуг. Вы признаете, что Dellee не несет ответственности или обязательств, прямо или косвенно, за любой ущерб или потери, вызванные или предположительно вызванные в связи с использованием или доверием к такому содержанию, товарам или услугам, доступным на таких веб-сайтах.</p>
        <p>Мы настоятельно рекомендуем Вам прочитать условия и политику конфиденциальности сторонних веб-сайтов или услуг, которые Вы посещаете.</p>
        <h2>Политика Конфедициальности</h2>
        <p>
          Мы можем использовать и раскрывать вашу информацию в соответствии с нашей <a href="/privacy">Политикой Конфиденциальности</a>. Наша Политика Конфиденциальности является частью настоящих Условий.
        </p>
        <h2>Управляющий Закон</h2>
        <p>Настоящие Условия будут регулироваться и толковаться в соответствии с законами Республики Казахстан, без учета его коллизионных норм.</p>
        <p>Неспособность нами исполнить любое право или положение настоящих Условий не будет считаться отказом от этих прав. Если какое-либо положение настоящих Условий будет признано недействительным или неисполнимым судом, остальные положения настоящих Условий остаются в силе.</p>
        <h2>Изменения</h2>
        <p>Мы оставляем за собой право, по своему собственному усмотрению, изменять или заменять данные Условия Использования в любое время. При существенных изменениях, мы постараемся уведомить Вас за 30 дней до вступления измененных Условий в силу. Мы по нашему собственному усмотрению определяем, что представляют собой существенные изменения.</p>
        <p>Продолжая использование нашего Сервиса после внесённых изменений, Вы соглашаетесь с ними. Если вы не согласны с новыми условиями, пожалуйста, прекратите использование Сервиса.</p>
        <h3>Свяжитесь с Нами</h3>
        <p>Если у Вас есть какие-либо вопросы по Условиям Использования, свяжитесь с нами по e-mail <a href={"mailto:#{config.contacts.email}"}>{config.contacts.email}</a>.</p>
      </div>
    </Content>
