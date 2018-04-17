import Nightmare from 'nightmare'
import assert from 'assert'

describe('FizzBuzzApp E2E', () => {
  const nightmare = Nightmare({show: false})
  const URL = 'http://localhost:8080'

  it('アクセスしたら「Click button」と表示されていること', (done) => {
    nightmare
      .goto(URL)
      .evaluate(() => {
        return document.getElementById('result').innerText
      })
      .then((text) => {
        assert.equal(text, 'Click button')
        done()
      })
  })
})
