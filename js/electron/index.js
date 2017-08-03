'use strict';

var electron = require('electron')
var remote = electron.remote
var vagrant = remote.require('./lib/vagrant')

vagrant.globalStatus((err, result) =>{
  if(!err) {
    var field = document.querySelector('#field')
    field.textContent = result
  }
})
