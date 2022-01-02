const Crypto = require('../utils/encryption')
const JWT = require('jsonwebtoken')
const Article = require('../models/model.article')

exports.register = async function (req, res) {
    try {
        const article = new Article({
            title: req.body.title,
            description: req.body.description,
            price: req.body.price,
        })
        await article.save();
        return res.status(200).json({ message: 'Article created', article: article })
    } catch (error) {
        if (error.name === 'ValidationError') {
            return res.status(400).json({ message: 'Invalid body' })
        } else {
            return res.status(500).json({error: error})
        }
    }
}

exports.retrieveAll = async function (req, res) {
    try {
        const articles = await Article.find();
        return res.status(200).json({ message: 'Articles fetched', articles: articles })
    } catch (error) {
        return res.status(500).json({error: error})
    }
}

 exports.retrieve = async function (req, res) {
    try {
        const article = await Article.findById(req.params.id);
        return res.status(200).json({ message: 'Article fetched', article: article })
    } catch (error) {
        return res.status(500).json({error: error})
    }
}
 