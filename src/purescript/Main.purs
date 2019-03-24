module Main where

import Components.Random as Random
import Control.Applicative (pure)
import Control.Bind (bind, discard)
import Control.Semigroupoid ((<<<))
import Data.Function (($))
import Data.Show (show)
import Data.Unit (Unit, unit)
import Effect (Effect)
import Effect.Aff.Compat (fromEffectFnAff)
import Effect.Class (liftEffect)
import Effect.Console (log)
--import Effect.Random as Random
import Halogen as Halogen
import Halogen.Aff (runHalogenAff, awaitBody)
import Halogen.VDom.Driver (runUI)

-- import Components.Random as Random

main :: Effect Unit
main = runHalogenAff do
    body <- awaitBody

    -- newNumber <- Halogen.liftEffect (Random.randomInt 0 255)
    -- newNumber <- (fromEffectFnAff <<< Random.randomInt) 0 255
    -- log $ show newNumber
    randomComponent <- runUI Random.component unit body
    -- randomComponent.query $ Halogen.action $ Random.Regenerate
    pure ""


{-
    Handling Events

    affEventSource
    lifecycleComponent
    https://stackoverflow.com/questions/44343300/halogen-keyboard-input-example-and-unsubsribing-to-the-events/44445047#44445047

    eventSource' :: forall f m a.     MonadAff                      m => ((a -> Effect                   Unit) -> Effect                   (Effect                   Unit)) -> (a -> Maybe (f SubscribeStatus)) -> EventSource f m
                                                                          |- callback                       -|                             |- Remove event listener     -|     |- MaybeQuery                 -|

    eventSource' :: forall f m a eff. MonadAff (avar :: AVAR | eff) m => ((a -> Eff (avar :: AVAR | eff) Unit) -> Eff (avar :: AVAR | eff) (Eff (avar :: AVAR | eff) Unit)) -> (a -> Maybe (f SubscribeStatus)) -> EventSource f m

    type Callback a = (a -> Eff (avar :: AVAR | eff) Unit)
    type MaybeQuery a = (a -> Maybe (f SubscribeStatus))
    type RemoveEventListener = (Eff (avar :: AVAR | eff) Unit)

    eventSource' :: forall f m a eff. (Callback a -> Eff (avar :: AVAR | eff) RemoveEventListener) -> MaybeQuery a -> EventSource f m
-}

