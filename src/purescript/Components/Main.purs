module Components.Main where

import Components.Password as PasswordComponent
import Components.PasswordSettings as PasswordSettingsComponent
import Control.Bind (bind, discard)
import Control.Category (identity)
import Control.Semigroupoid ((<<<))
import Crypto as Crypto
import Data.Either (Either(..))
import Data.Eq (class Eq)
import Data.Function (($))
import Data.Maybe (Maybe(..), maybe)
import Data.Semigroup ((<>))
import Data.Set (Set)
import Data.Show (show)
import Data.Symbol (SProxy(..))
import Data.Unit (Unit, unit)
import Data.Void (absurd)
import Effect.Aff.Class (class MonadAff)
import Effect.Class.Console (log)
import Halogen as Halogen
import Halogen.HTML as HTML
import Halogen.HTML.Events as Events
import Node.Buffer (toString)
import Node.Encoding (Encoding(..))
import State.PasswordSettings (Password(..), PasswordSettings, PasswordStrength(..), PasswordCharset(..))
import Unsafe.Coerce (unsafeCoerce)

type State = {
    passwordSettings ::PasswordSettings,
    password :: Maybe Password
}
data Action = Regenerate
            | HandleChangedPassword PasswordComponent.Message

arrayToSet :: forall a. Eq a => Array a -> Set a
arrayToSet = unsafeCoerce

updatePassword :: Password -> State -> State
updatePassword value {passwordSettings:s, password:_} = {passwordSettings:s, password:Just value}

-- =================================================

type ChildSlots = (
    passwordSettings    :: PasswordSettingsComponent.Slot   Unit,
    passsword           :: PasswordComponent.Slot           Unit
)

_passwordSettingsSlot    = SProxy :: SProxy "passwordSettings"
_passwordSlot            = SProxy :: SProxy "password"

-- =================================================

component :: forall q i o m. MonadAff m => Halogen.Component HTML.HTML q i o m
component = Halogen.mkComponent {
    initialState,
    render,
    eval: Halogen.mkEval $ Halogen.defaultEval { handleAction = handleAction }
}

initialState :: forall i. i -> State
initialState _ = {
    passwordSettings: {
        strength: Left VeryStrong,
        characters: Left (arrayToSet [UppercaseLetters, LowercaseLetters, Digits])
    },
    password: Nothing
}

render :: forall m. State -> Halogen.ComponentHTML Action ChildSlots m
render state =
    let
        value = maybe "No number generated yet" show state.password
    in
        HTML.div [] [
            HTML.h1 [] [HTML.text "Random number"],
            HTML.div [] [
                HTML.slot   _passwordSlot                                   --  slot address label
                            unit                                            --  slot address index
                            PasswordComponent.component                     --  component
                            (maybe (Password "") identity state.password)   --  input value
                            (Just <<< HandleChangedPassword)                --  function mapping outputs (messages) from the component to query in the paret
            ],
            HTML.p  [] [HTML.text ("Current value: " <> value)],
            HTML.button [ Events.onClick \_ -> Just Regenerate] [ HTML.text "Generate new random value" ]
        ]

handleAction ∷ forall o m. MonadAff m => Action → Halogen.HalogenM State Action ChildSlots o m Unit
handleAction = case _ of
    Regenerate -> do
        newNumber <- Halogen.liftEffect (Crypto.randomBytes 8)
        value     <- Halogen.liftEffect (toString Hex newNumber)
        --Halogen.modify_ \s -> ({passwordSettings, s.passwordSettings, password: Just value})
        Halogen.modify_ (updatePassword (Password value))
    HandleChangedPassword (PasswordComponent.Regenerated (Password password)) -> do
        log("Updated password")
        Halogen.modify_ (updatePassword (Password password))
