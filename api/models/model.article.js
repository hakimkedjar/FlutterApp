const mongoose = require("mongoose")

const schema = mongoose.Schema({
    title: {type: String, required: true},
    description: {type: String, required: true},
    price: {type: Number, default: 5},
})

module.exports = mongoose.model("Article", schema)