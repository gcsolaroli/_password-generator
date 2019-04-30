"use strict"

const crypto = require("crypto")

exports.nativeGenerateRandomNumber = function(n) {
    return function () {
        return crypto.randomBytes(n)
    }
}