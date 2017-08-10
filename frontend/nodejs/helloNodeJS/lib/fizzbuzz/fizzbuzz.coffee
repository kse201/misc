class Fizzbuzz
  fizz = 'fizz'
  buzz = 'buzz'

  say: (number) ->
    switch
      when number % (3 * 5) == 0
        fizz + buzz
      when number % 3 == 0
        fizz
      when number % 5 == 0
        buzz
      else
        number

module.exports = Fizzbuzz
