require('coffee-script/register');
var database = require('lib/database');
var User = require('server/models/user')
var log = require('lib/logger').bind({ logPrefix: '[create admin]' });


database(function () {
  admin = new User({
    username: 'admin',
    password: '123456789',
    role: 'admin',
    created: new Date()
  });

  admin.save(function (err) {
    if (err) {
      log(err.message || err, 'red bold');
    } else {
      log('admin created', 'green');
    }
  });
});
