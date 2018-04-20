# Description:
#   Example scripts for http response
#

util = require 'util'

module.exports = (robot) ->

  # set view
  robot.router.set('view engine', 'pug')

  robot.router.get '/', (req, res) ->
    res.render 'index', {
      title: 'Hubot index'
    }

  # GET /hubot
  robot.router.get '/hubot', (req, res) ->
    # get data from kvs(hugot-bain)
    post = robot.brain.get('post') ? ''
    res.render 'hubot', {
      title: 'hubot',
      post: post,
      headers: util.inspect(req.headers, {showHidden: false, depth: null})
    }

  # POST /hubot/post -d '{ "post": "post"}'
  robot.router.post '/hubot/post', (req, res) ->
    # set data from kvs(hugot-bain)
    post = robot.brain.set('post', req.body.post) ? ''
    res.redirect '/hubot'

  robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
    room   = req.params.room
    data   = JSON.parse req.body.payload
    secret = data.secret

    robot.messageRoom room, "I have a secret: #{secret}"

    res.send 'OK'
