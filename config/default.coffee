module.exports =
  host: 'localhost'

  server:
    port: parseInt(process.env.PORT, 10) or 3000
    ip: '127.0.0.1'

  mongodb:
    host: 'localhost'
    database: 'dellee'

  admin:
    jwt:
      expires: 86400
      secret: 'whatdidyouwanttoseehere'

  public:
    jwt:
      expires: 86400
      secret: 'ourlittlesecret'

  mail:
    default_from: 'Dellee <hello@dellee.me>'
    mailgun:
      key: 'key-e9651b7f70bf011ab5d000e5a01ab8b7'
      domain: 'sandbox60c1d1eb15aa486c999a81aa410ef821.mailgun.org'

  sms:
    default_from: 'Dellee'
    nexmo:
      key: '01943c03'
      secret: '9c73f5ef'
      cost: '0.0297'

  queue:
    chunk_size: 2 # Number of tasks from queue to be processed per iteration.
    timeout: 1000 # Timeout after each iteration in milliseconds.
    # attempts: 5 # Number of attempts to complete task before it will be failed.

  cdn:
    storage: "#{__dirname}/../cdn"

  meta:
    title: 'Dellee • Личный Менеджер Подписок'
    description: 'Dellee - лучший и удобный способ следить за новостями и акциями любимых заведений'
    keywords: 'dellee.me, менеджер подписок, астана, акции, новости'

  # Client
  contacts:
    email: 'info@dellee.me'

  fb:
    version: 'v2.5'
    app_id: '1708242352752774'

  ga:
    id: 'UA-72780272-1'
