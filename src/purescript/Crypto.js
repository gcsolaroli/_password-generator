"use strict"

//const sjcl = require ("sjcl")

// https://github.com/diafygi/webcrypto-examples

/*
- https://stackoverflow.com/a/22958889
    If the data is authenticated by an asymmetric signature use CBC, otherwise use GCM.

*/

const getRandomValues = function (n) {
    return Buffer.from(crypto.getRandomValues(new Uint8Array(n)));
//  return Buffer.from(sjcl.random.randomWords(n));
}

exports._getRandomValues = function (n) {
    return function () {
        return getRandomValues(n);
    }
}

/*
const logEntropy = function (when) {
    console.log(when + " - PRNG is ready?", sjcl.random.isReady());
    console.log(when + " - PRNG is ready? (paranoia level 10)", sjcl.random.isReady(10));
}

logEntropy("bootstrap");
sjcl.random.addEventListener("progress", function (event) { console.log("SJCL event: ", event); return event; })
sjcl.random.startCollectors();

window.setTimeout ( function() { logEntropy("3 seconds later"); }, 3000);
*/