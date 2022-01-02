const jwt = require('jsonwebtoken')

module.exports.verify = function(req, res, next) {
    try {
        const bearerHeader = req.headers["authorization"]
        const accessToken = bearerHeader.split(" ")[1]
        req.decodedToken = jwt.verify(accessToken, process.env.KEY_JWT)
        req.accessToken = accessToken
        next()
    } catch (error) {
        return res.status(403).json({ message: 'Invalid token '})
    }
}