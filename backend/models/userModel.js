const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    username: {
        required: true,
        type: String
    },
    email: {
        required: true,
        type: String
    },
    password: {
        required: true,
        type: String
    },
    resetToken: {
        type: String
    },
    resetTokenExpires: {
        type: Date
    }
});

module.exports = mongoose.model('userCollection', userSchema);
