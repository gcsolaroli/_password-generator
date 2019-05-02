"use strict"

// https://github.com/diafygi/webcrypto-examples

/*
- https://stackoverflow.com/a/22958889
    If the data is authenticated by an asymmetric signature use CBC, otherwise use GCM.

*/

const bufferFromArrayBuffer = function (ab) {
    return Buffer.from(ab);
};
  
const bufferToArrayBuffer = function (buff) {
    return buff.buffer.slice(buff.byteOffset, buff.byteOffset + buff.byteLength);
};
  
const getRandomValues = function (n) {
    return Buffer.from(crypto.getRandomValues(new Uint8Array(n)));
}

exports._getRandomValues = function (n) {
    return function () {
        return getRandomValues(n);
    }
}