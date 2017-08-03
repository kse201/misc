'use strict';

var exec = require('child_process').exec

var vagrant = {
  globalStatus: (callback) => {
    exec('vagrant global-status', (err, stdout,stderr) => {
      if (err) {
        callback(err, stderr);
      }
      callback(null, stdout);
    })
  }
}

module.exports = vagrant;
