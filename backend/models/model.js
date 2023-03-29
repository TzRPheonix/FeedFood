const mongoose = require('mongoose');

const dataSchema = new mongoose.Schema({
    value: {
        required: true,
        type: String
    }
})

module.exports = mongoose.model('Data', dataSchema)