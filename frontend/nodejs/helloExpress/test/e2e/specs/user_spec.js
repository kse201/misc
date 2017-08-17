module.exports = {
  tag: 'user',
  'Users': function (client) {
    client
      .url('http://localhost:3000/users')
      .assert.containsText('div#main', 'Not Implemented: user list')
      .end()
  }
}
