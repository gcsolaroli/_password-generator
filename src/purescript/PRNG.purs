module PRNG where

import Data.Ring ((-))
import Data.Sequence (Seq, empty, cons)
import Effect.Aff (Aff, makeAff)
import Effect.Class (liftEffect)
import Effect.Random as Random

type Bytes = Seq Int

randomBytes :: Int -> Aff Bytes
--randomBytes :: Int -> Aff (Seq Int)
randomBytes n = makeAff empty -- _randomBytes n
    where
        _randomBytes :: Int -> Seq (Aff Int)
        _randomBytes 0 = empty
        _randomBytes n' = cons (liftEffect (Random.randomInt 0 255)) (_randomBytes (n' - 1))
