const router = require('express').Router()
const controllers = require('../controllers/controller.article')
const jwt = require('../middlewares/jwt')

router.post('/register', controllers.register)
router.get('/retrieve-all', jwt.verify, controllers.retrieveAll)
router.get('/retrieve/:id', jwt.verify, controllers.retrieve)

module.exports = router