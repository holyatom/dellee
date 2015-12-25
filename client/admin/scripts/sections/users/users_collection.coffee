Collection = require('admin/base/collection')


module.exports = class UsersCollection extends Collection
  urlPath: '/users'

  fields: ['username', 'role']
  fieldNames:
    username: 'Логин'
    role: 'Роль'
