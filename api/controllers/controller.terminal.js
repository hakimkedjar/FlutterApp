const Crypto = require('../utils/encryption')
const JWT = require('jsonwebtoken')
const Terminal = require('../models/model.terminal')
const Account = require('../models/model.account')

exports.register = async function (req, res) {
    try {
        const terminal = new Terminal({
            region: req.body.region,
            password: Crypto.encrypt(req.body.password),
        })
        await terminal.save();
        return res.status(200).json({ message: 'Terminal created', terminal: terminal })
    } catch (error) {
        if (error.name === 'ValidationError') {
            return res.status(400).json({ message: 'Invalid body' })
        } else {
            return res.status(500).json({error: error})
        }
    }
 }

 exports.login = async function (req, res) {
    try {
        if (!req.body.password || !req.body.region) {
            return res.status(400).json({ message: 'Invalid body' })
        }
        const terminal = await Terminal.findOne({ region: req.body.region })
        if (!terminal || !Crypto.decrypt(terminal.password, req.body.password)) {
            return res.status(400).json({ message: 'Invalid e-mail or password' })
        }
        const accessToken = JWT.sign({ _id: terminal._id },process.env.KEY_JWT,{ expiresIn: '12h' })
        return res.status(200).json({ message: 'Terminal logged', accessToken: accessToken })
    } catch (error) {
        if (error.name === 'ValidationError') {
            return res.status(400).json({ message: 'Invalid body' })
        } else {
            return res.status(500).json()
        }
    }
}
 
 exports.pay = async function (req, res) {
    try {
        if (!req.body.code || !req.body.balance) {
            return res.status(400).json({ message: 'Invalid body'})
        }
        const account = await Account.findOne({ code: req.body.code })
        if(!account) {
            return res.status(400).json({ message: 'Invalid code' })
        }
        const balance = account.balance
        if(balance > req.body.balance) {
            account.balance -= req.body.balance
            await Account.updateOne({ code: req.body.code }, { balance: account.balance})
            return res.status(200).json({ message: 'Payment accepted'})
        } else {
            return res.status(400).json({ message: 'You don\'t have enough balance'})
        }
    } catch (error) {
        if (error.name === 'ValidationError') {
            return res.status(400).json({ message: 'Invalid body' })
        } else {
            return res.status(500).json()
        }
    }
}
 