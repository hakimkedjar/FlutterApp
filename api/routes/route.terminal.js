const router = require('express').Router()
const controllers = require('../controllers/controller.terminal')
const jwt = require('../middlewares/jwt')

router.post('/register', controllers.register)
router.get('/login', controllers.login)
router.post('/pay', jwt.verify, controllers.pay)

module.exports = router