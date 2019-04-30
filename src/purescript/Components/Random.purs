module Components.Random where

import Control.Bind (bind)
import Data.Function (($))
import Data.Maybe (Maybe(..), maybe)
import Data.Semigroup ((<>))
import Data.Show (show)
import Data.Unit (Unit)
import Effect.Aff.Class (class MonadAff)
import Halogen as Halogen
import Halogen.HTML as HTML
import Halogen.HTML.Events as Events
import Node.Buffer (Buffer)
import PRNG as PRNG


type State = Maybe Buffer
data Action = Regenerate

component :: forall q i o m. MonadAff m => Halogen.Component HTML.HTML q i o m
component = Halogen.mkComponent {
        initialState,
        render,
        eval: Halogen.mkEval $ Halogen.defaultEval { handleAction = handleAction }
    }

    where

    initialState :: forall i. i -> State
    initialState _ = Nothing

    render :: forall m. State -> Halogen.ComponentHTML Action () m
    render state =
        let
            value = maybe "No number generated yet" show state
        in
            HTML.div [] [
                HTML.h1 [] [HTML.text "Random number"],
                HTML.p  [] [HTML.text ("Current value: " <> value)],
                HTML.button [ Events.onClick \_ -> Just Regenerate] [ HTML.text "Generate new random value" ]
            ]

    handleAction ∷ forall o m. MonadAff m => Action → Halogen.HalogenM State Action () o m Unit
    handleAction = case _ of
        Regenerate -> do
            newNumber <- Halogen.liftEffect (PRNG.randomBytes 8)
            Halogen.modify_ \st -> (Just newNumber)