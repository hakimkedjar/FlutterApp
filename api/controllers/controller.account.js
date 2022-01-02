const Crypto = require('../utils/encryption')
const JWT = require('jsonwebtoken')
const Account = require('../models/model.account')

exports.register = async function (req, res) {
    try {
        const account = new Account({ code: req.body.code })
        await account.save();
        return res.status(200).json({ message: 'Account created', account: account })
    } catch (error) {
        if (error.name === 'ValidationError') {
            return res.status(400).json({ message: 'Invalid body' })
        } else {
            return res.status(500).json({error: error})
        }
    }
}
