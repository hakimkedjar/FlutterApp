const Crypto = require("crypto-js")

exports.encrypt = function (password) {
    return Crypto.AES.encrypt(password, process.env.KEY_ENCRYPTION).toString()
}

exports.decrypt = function (passwordEncrypted, password) {
    let bytes  = Crypto.AES.decrypt(passwordEncrypted, process.env.KEY_ENCRYPTION);
    return bytes.toString(Crypto.enc.Utf8) === password
}