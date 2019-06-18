module Components.PasswordSettings where

import Control.Applicative (pure)
import Control.Bind (bind)
import Control.Category (identity)
import Data.Function (($))
import Data.Maybe (Maybe(..))
import Data.Void (Void)
import Data.Unit (Unit)
import Halogen as Halogen
import Halogen.HTML as HTML
import State.PasswordSettings (PasswordSettings)

type Slot = Halogen.Slot Query Void
type State = PasswordSettings
data Query a = GetState (PasswordSettings -> a)
data Action = Update

component :: forall o m. Halogen.Component HTML.HTML Query PasswordSettings o m
component = Halogen.mkComponent {
    initialState,
    render,
    eval: Halogen.mkEval $ Halogen.defaultEval { handleAction = handleAction, handleQuery = handleQuery }
}


initialState :: PasswordSettings -> State
initialState = identity

render :: forall m. State -> Halogen.ComponentHTML Action () m
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
    Update -> do
        Halogen.modify_ identity

handleQuery :: forall o m a. Query a -> Halogen.HalogenM State Action () o m (Maybe a)
handleQuery = case _ of
  GetState k -> do
    state <- Halogen.get
    pure (Just (k state))

