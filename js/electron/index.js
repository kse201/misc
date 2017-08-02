'use strict';

var electron = require('electron');
var remote = electron.remote;
var fileUtil = remote.require('./lib/fileUtil');

fileUtil.fetchReadmeList(function(err, matches) {
  if(!err) document.write(matches.join());
});
