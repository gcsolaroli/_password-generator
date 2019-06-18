module Components.Password where

import Control.Applicative (pure)
import Control.Bind (bind)
import Control.Category (identity)
import Data.Function (($), const)
import Data.Maybe (Maybe(..))
import Data.Void (Void)
import Data.Unit (Unit)
import Halogen as Halogen
import Halogen.HTML as HTML
import State.PasswordSettings (Password)

type Slot = Halogen.Slot () Void
type State = Password
data Action = Regenerate

component :: forall q o m. Halogen.Component HTML.HTML q Password o m
component = Halogen.mkComponent {
    initialState,
    render,
    eval: Halogen.mkEval $ Halogen.defaultEval { handleAction = handleAction },
    receiver: const Nothing
}


initialState :: Password -> State
initialState = identity

render :: forall m. State -> Halogen.ComponentHTML Void () m
render state =
    let
        value = "maybe \"No number generated yet\" identity state.password"
    in
        HTML.div [] [
            HTML.h1 [] [HTML.text "Password settings"]
            --HTML.p  [] [HTML.text ("Current value: " <> value)],
            --HTML.button [ Events.onClick \_ -> Just Regenerate] [ HTML.text "Generate new random value" ]
        ]

handleAction :: forall o m. Action -> Halogen.HalogenM State Action () o m Unit
handleAction = case _ of
    Regenerate -> do
        Halogen.modify_ identity


