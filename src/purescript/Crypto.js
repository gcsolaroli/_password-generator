"use strict"

// https://github.com/diafygi/webcrypto-examples

/*
- https://stackoverflow.com/a/22958889
    If the data is authenticated by an asymmetric signature use CBC, otherwise use GCM.

*/

exports._getRandomValues = function (n) {
    return function () {
        return Buffer.from(crypto.getRandomValues(new Uint8Array(n)));
    }
}