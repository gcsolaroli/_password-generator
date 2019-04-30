module Test.PRNG where

import Control.Bind (bind)
import Effect.Class.Console (log)
import Data.Unit (Unit)
import Effect (Effect)
import PRNG as PRNG

main :: Effect Unit
main = do
  bytes <- PRNG.randomBytes 64
  log "You should add some tests."

