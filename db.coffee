mongoose = require 'mongoose'

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

exports.Echo = mongoose.model 'Echo', new Schema
  title: String
  author: String
  repository: String
  homepage: String
  type: String
  content: String

if process.env.MONGOLAB_URI
  mongoose.connect process.env.MONGOLAB_URI

else
  mongoose.connect 'mongodb://localhost/echotron'

# ---

# echo = new Echo
# echo.title = 'ABC123'
# echo.save()

# exports.Echo.find {}, (err, docs) ->
#   console.log docs[0].title, docs.length

# exports.Echo.remove {}, (err) ->
#   console.log "omg #{err}"

