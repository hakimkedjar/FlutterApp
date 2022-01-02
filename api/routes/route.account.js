const router = require('express').Router()
const controllers = require('../controllers/controller.account')
const jwt = require('../middlewares/jwt')

router.post('/register', controllers.register)

module.exports = router