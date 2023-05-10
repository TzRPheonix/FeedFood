const mongoose = require('mongoose');

const postSchema = new mongoose.Schema({
  title: {
    required: true,
    type: String
  },
  image: {
    required: true,
    type: String
  },
  description: {
    required: true,
    type: String
  },
  createdBy: {
    required: true,
    type: mongoose.Schema.Types.ObjectId,
    ref: 'userCollection'
  }
});

module.exports = mongoose.model('postCollection', postSchema)
