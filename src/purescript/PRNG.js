"use strict"

exports.nativeGenerateRandomNumber = function (n) {
    return function () {
        return Buffer.from(crypto.getRandomValues(new Uint8Array(n)));
    }
}