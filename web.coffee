express = require 'express'
UglifyJS = require 'uglify-js'

db = require './db'
Echo = db.Echo

app = express express.logger()
app.use express.bodyParser()

renderEchoes = (res, echoes) ->
  echoContents =
    for echo in echoes
      echo.content

  res.type 'js'
  res.send UglifyJS.minify(echoContents.join("\n"), fromString: yes).code


app.get '/echoes.js', (req, res) ->
  Echo.find {}, (err, echoes) ->
    renderEchoes res, echoes

app.get '/echoes/:id.js', (req, res) ->
  { title, type } = req.params
  Echo.findById req.params.id, (err, echo) ->
    renderEchoes res, [echo]

app.get '/echoes.json', (req, res) ->
  Echo.find {}, (err, echoes) ->
    res.type 'json'
    res.send(echo.toSlimJSON() for echo in echoes)


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
      res.send echo.toSlimJSON()



port = process.env.PORT || 5000
app.listen port, ->
  console.log "Listening on #{port}"