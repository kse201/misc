import assert from 'assert'
import FizzBuzzApp from '../../src/FizzBuzzApp'

describe('FizzBuzzApp', () => {
  const fizzBuzzApp = new FizzBuzzApp()
  describe('convertFizzBuzz', () => {

    it('return Fizz when count is 3', () => {
      assert.equal(fizzBuzzApp.convertFizzBuzz(3), 'Fizz')
    })

    it('return Fizz when count is 4', () => {
      assert.equal(fizzBuzzApp.convertFizzBuzz(4), '4')
    })

    it('return Fizz when count is 5', () => {
      assert.equal(fizzBuzzApp.convertFizzBuzz(5), 'Buzz')
    })

  });
})
