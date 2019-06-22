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

type Slot = Halogen.Slot Query Message
type Input = Password
data Query a = GetPassword (Password -> a)
data Message = Regenerated Password
type State = { password:: Password }
data Action = Regenerate

component :: forall m. Halogen.Component HTML.HTML Query Input Message m
component = Halogen.mkComponent {
    initialState,
    render,
    eval: Halogen.mkEval $ Halogen.defaultEval { handleAction = handleAction, handleQuery = handleQuery }
    -- receiver: const Nothing
}

initialState :: Password -> State
initialState password = { password: password }

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

handleAction :: forall m. Action -> Halogen.HalogenM State Action () Message m Unit
handleAction = case _ of
    Regenerate -> do
        -- Halogen.modify_ identity
        newState <- Halogen.modify identity
        Halogen.raise (Regenerated newState.password)        

handleQuery :: forall m a. Query a -> Halogen.HalogenM State Action () Message m (Maybe a)
handleQuery = case _ of
  GetPassword k -> do
    password <- Halogen.gets _.password
    pure (Just (k password))

