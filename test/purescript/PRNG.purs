module Test.PRNG where


import PRNG as PRNG

main :: Effect Unit
main = do
  bytes <- PRNG.randomBytes 64
  log "You should add some tests."

