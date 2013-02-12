mongoose = require 'mongoose'
if process.env.MONGOLAB_URI
  mongoose.connect process.env.MONGOLAB_URI
else
  mongoose.connect 'mongodb://localhost/echotron'


Schema = mongoose.Schema
ObjectId = Schema.ObjectId

exports.Echo = Echo = mongoose.model 'Echo', new Schema
  title: String
  author: String
  repository: String
  homepage: String
  type: String
  content: String

Echo::toSlimJSON = ->
  json = @toJSON()
  
  # _id -> id
  json.id = json._id
  delete json._id

  # __v -> revision
  json.revision = json.__v
  delete json.__v

  # Remove content
  delete json.content

  # Add a path where you can get the content
  json.path = "/echoes/#{@type}/#{@title}.js"

  # Return the prepped object.
  json

# ---

# echo = new Echo
# echo.title = 'ABC123'
# echo.save()

# exports.Echo.find {}, (err, docs) ->
#   console.log docs[0].title, docs.length

# exports.Echo.remove {}, (err) ->
#   console.log "omg #{err}"

