express = require 'express'
UglifyJS = require 'uglify-js'

db = require './db'
Echo = db.Echo

app = express express.logger()
app.use express.bodyParser()

app.get '/echoes.js', (req, res) ->
  Echo.find {}, (err, echoes) ->
    body = (echo.content for echo in echoes).join("\n")
    
    res.type 'js'
    res.send UglifyJS.minify(body, fromString: yes).code


app.post '/', (req, res) ->
  echo = null
  Echo.find title: req.body.title, author: req.body.author, (err, echoes) ->
    console.error err if err
    echo = echoes[0] || new Echo

    echo.title      = req.body.title
    echo.author     = req.body.author
    echo.repository = req.body.repository
    echo.homepage   = req.body.homepage
    echo.type       = req.body.type
    echo.content    = req.body.content

    echo.save (err) ->
      console.error err if err

      res.type 'js'
      res.send echo



port = process.env.PORT || 5000
app.listen port, ->
  console.log "Listening on #{port}"