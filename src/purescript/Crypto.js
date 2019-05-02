"use strict"

// https://github.com/diafygi/webcrypto-examples

exports._getRandomValues = function (n) {
    return function () {
        return Buffer.from(crypto.getRandomValues(new Uint8Array(n)));
    }
}