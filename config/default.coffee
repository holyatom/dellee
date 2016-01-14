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
      expires: 1440
      secret: 'whatdidyouwanttoseehere'

  public:
    jwt:
      expires: 1440
      secret: 'ourlittlesecret'

  mail:
    default_from: 'Dellee <info@dellee.me>'
    mailgun:
      key: 'key-e9651b7f70bf011ab5d000e5a01ab8b7'
      domain: 'sandbox60c1d1eb15aa486c999a81aa410ef821.mailgun.org'

  queue:
    chunk_size: 2 # Number of tasks from queue to be processed per iteration.
    timeout: 1000 # Timeout after each iteration in milliseconds.
    # attempts: 5 # Number of attempts to complete task before it will be failed.

  cdn:
    storage: "#{__dirname}/../cdn"
