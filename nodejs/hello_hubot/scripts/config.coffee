module.exports = (robot) ->
  robot.router.set('view engine', 'pug')

  robot.router.get '/config', (req, res) ->
    res.render 'config', {
      title: 'config',
      config: 'foo'
    }

  robot.router.get '/config/new', (req, res) ->
    res.render 'config/new'

  robot.router.post '/config', (req, res) ->
    console.log(req.param('say'))
    res.render 'config', {
      config: req.param('say')
    }
