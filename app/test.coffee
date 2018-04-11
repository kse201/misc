glob = require 'glob'

find = (pattern) ->
    glob pattern, (err, files) ->
        if err
            console.log err
        console.log pattern
        console.log files

pattern = "routes/*.js"
find(pattern)
