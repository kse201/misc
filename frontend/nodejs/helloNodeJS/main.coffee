hash = {
  hello: (msg="nodejs")->
    console.log("Hello #{msg}")
}

hash.hello()
hash.hello 'function call with args'

class Cls
  constructor: (@msg) ->

  hello: ->
    console.log("Hello #{@msg}")

cls = new Cls('class in node.js')
cls.hello()

func = (msg)->
  console.log("#{msg} is first object")

func "Function" 
