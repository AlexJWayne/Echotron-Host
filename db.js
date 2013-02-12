// Generated by CoffeeScript 1.3.3
(function() {
  var ObjectId, Schema, mongoose;

  mongoose = require('mongoose');

  Schema = mongoose.Schema;

  ObjectId = Schema.ObjectId;

  exports.Echo = mongoose.model('Echo', new Schema({
    title: String,
    author: String,
    repository: String,
    homepage: String,
    type: String,
    content: String
  }));

  mongoose.connect(process.env.MONGOLAB_URI || 'mongodb://localhost/echotron');

}).call(this);
