module.exports = {
  tag: 'user',
  'Users': function (client) {
    client
      .url('http://localhost:3000/users')
      .assert.title('Users')
      .assert.containsText('div#users', 'Not Implemented: user list')
      .end()
  }
}
