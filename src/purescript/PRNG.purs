module PRNG where

import Data.Ring ((-))
import Data.Sequence (Seq, append, singleton)
import Effect (Effect)
import Effect.Random as Random

type Bytes = Seq Int

randomBytes :: Int -> Effect Bytes
randomBytes 1 = singleton (Random.randomInt 0 255)
randomBytes s = append randomBytes(s - 1) randomBytes(1)
