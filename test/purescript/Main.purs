module Test.Main where

--import Prelude
import Control.Bind (discard)
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Console (log)

import Main as Main

main :: Effect Unit
main = do
  Main.main
  log "You should add some tests."
