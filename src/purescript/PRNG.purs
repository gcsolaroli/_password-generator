module PRNG where

import Control.Applicative (pure)
import Control.Bind (bind)
import Data.Function (($))
import Data.Ring ((-))
import Data.Sequence (Seq, empty, cons)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Random as Random
import Halogen as Halogen
import Pipes.Core (Producer)

type Bytes = Seq Int

--  https://github.com/felixSchl/purescript-pipes/blob/master/examples/Example.purs

randomBytes :: Int -> Aff Bytes
randomBytes n = Halogen.liftEffect $ pure empty -- _randomBytes n
    where
        _randomBytes :: Int -> Seq (Aff Int)
        _randomBytes 0 = empty
        _randomBytes n' = cons (Halogen.liftEffect (Random.randomInt 0 255)) (_randomBytes (n' - 1))



pipedRandomInt :: Producer Effect Int
pipedRandomInt = do
    r <- liftEffect $ Random.randomInt 0 255
    pure r