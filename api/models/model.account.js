const mongoose = require("mongoose")

const schema = mongoose.Schema({
    code: {type: String, required: true, unique: true},
    balance: {type: Number, default: 400},
})
 
module.exports = mongoose.model("Account", schema)