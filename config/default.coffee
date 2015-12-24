module.exports =
  host: 'localhost'

  server:
    port: parseInt(process.env.PORT, 10) or 3000
    ip: '127.0.0.1'

  mongodb:
    host: 'localhost'
    database: 'dellee'
