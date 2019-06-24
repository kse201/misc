import hubot = require("hubot")

module.exports = (robot: hubot.Robot<any>): void => {
  robot.respond(/hello/i, (msg: hubot.Response<any>) => {
    msg.reply('world')
  })
}
