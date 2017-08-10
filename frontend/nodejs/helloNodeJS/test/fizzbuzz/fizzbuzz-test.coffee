chai = require 'chai'
expect = chai.expect
chai.should()

FizzBuzz = require '../../lib/fizzbuzz/fizzbuzz'

describe 'Fizzbuzz', ->
  subject = null

  describe '#say', ->
    before ->
      subject = new FizzBuzz

    test_cases = [
      {input: 1, expect: 1}
      {input: 3, expect: 'fizz'}
      {input: 5, expect: 'buzz'}
      {input: 15, expect: 'fizzbuzz'}
    ]

    for t in test_cases
      context "given #{t.input}", ->
        it "return #{t.expect}", ->
          subject.say(t.input).should.equal t.expect
