const mongoose = require("mongoose")

const schema = mongoose.Schema({
    region: {type: String, required: true, unique: true},
    password: {type: String, required: true},
})

module.exports = mongoose.model("Terminal", schema)