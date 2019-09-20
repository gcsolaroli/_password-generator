module Components.Main where

import Prelude

-- import Components.Password as PasswordComponent
import Components.Settings as Components.Settings
-- import Control.Applicative (pure)
-- import Data.Eq (class Eq)
-- import Data.Function (($), const)
import Data.Maybe (Maybe(..))
-- import Data.Ord (class Ord)
import Data.Symbol (SProxy(..))
-- import Data.Unit (Unit, unit)
import Effect.Aff.Class (class MonadAff)
import Halogen as Halogen
import Halogen.HTML as HTML

-- import Halogen.Query.EventSource (finalize)

{-
- `surface` is the type that will be rendered by the component, usually `HTML`               :: Type -> Type -> Type
- `query` is the query algebra; the requests that can be made of the component               :: Type -> Type
- `input` is the input value that will be received when the parent of this component renders :: Type
- `output` is the type of messages the component can raise                                   :: Type
- `m` is the effect monad used during evaluation                                             :: Type -> Type
-}

--type    Settings    = SettingComponent.Settings
type    Settings    = Components.Settings.Settings

type    Surface     = HTML.HTML

data    Action      = NoAction
                    -- | SettingComponent_NoAction  SettingComponent.Action
                    -- | PasswordComponent_NoAction PasswordComponent.Action
data    Query a     = NoQuery a
type    Input       = Settings
data    Output      = NoOutput      -- aka Message
type    State       = {
    settings:: Settings,
    password:: String
}

newtype SlotIdentifier = SlotIdentifier Int
derive instance eqSlotIdentifier  :: Eq  SlotIdentifier
derive instance ordSlotIdentifier :: Ord SlotIdentifier

type Slots = (
    settings :: SlotIdentifier,
    password :: SlotIdentifier 
)

_settings :: SProxy "settings"
_settings = SProxy

_password :: SProxy "password"
_password = SProxy

initialState :: Input -> State
initialState s = { settings: s, password: "" }

-- component :: forall m. {- MonadAff m => -} Halogen.Component Surface Query Input Output m
component :: forall m. MonadAff m => Halogen.Component Surface Query Input Output m
component = Halogen.mkComponent {
    initialState ,                                      -- :: Input -> State
    render,                                             -- :: State -> Surface (ComponentSlot Surface Slots m Action) Action
    eval: Halogen.mkEval $ Halogen.defaultEval {        -- :: HalogenQ query action input ~> HalogenM state action slots output m
        initialize   = initialize   :: Maybe Action,
        receive      = receive      :: Input -> Maybe Action,
        handleAction = handleAction :: forall m.   MonadAff m => Action  → Halogen.HalogenM State Action Slots Output m Unit,
        handleQuery  = handleQuery  :: forall m a. MonadAff m => Query a -> Halogen.HalogenM State Action Slots Output m (Maybe a),
        finalize     = finalize     :: Maybe Action
    }
                    -- :: HalogenQ Query Action Input ~> HalogenM State Action Slots Output m
}

-- render :: forall m. {- MonadAff m => -} State -> Halogen.ComponentHTML Action Slots m
render :: forall m. MonadAff m => State -> Halogen.ComponentHTML Action Slots m
--render :: State -> Surface (ComponentSlot Surface Slots m Action) Action
--render ({settings: settings, password: password}) = HTML.div [] [
render ({settings: { length : length }, password: password}) = HTML.div [] [
    HTML.h1  [] [HTML.text "Hello!"],
    -- HTML.div [] [HTML.slot _settings (SlotIdentifier 1) SettingComponent.component (settings) (Just <<< SettingComponent_NoAction)],
    -- HTML.div [] [HTML.slot _password (SlotIdentifier 2) PasswordComponent.component (password) (Just <<< PasswordComponent_NoAction)],
    HTML.div [] [HTML.span [] [HTML.text "length:"],   HTML.span [] [HTML.text (show length)]],
    HTML.div [] [HTML.span [] [HTML.text "password:"], HTML.span [] [HTML.text password]],
    HTML.hr_
]

-- handleAction ∷ forall m. {- MonadAff m => -} Action → Halogen.HalogenM State Action Slots Output m Unit
handleAction ∷ forall m. MonadAff m => Action → Halogen.HalogenM State Action Slots Output m Unit
handleAction = case _ of
    NoAction ->
        pure unit
    -- SubComponentOutput (SubComponent.S_NoOutput) ->
    --     pure unit
    -- SubComponentOutput (SubComponent.S_Click_Happened) ->
    --     Halogen.modify_ (\(State counter) -> State (counter + 1))

handleQuery :: forall m a. Query a -> Halogen.HalogenM State Action Slots Output m (Maybe a)
handleQuery = const (pure Nothing)
--handleQuery = case _ of
--  NoQuery k -> do
--    pure (Just (k))

receive :: Input -> Maybe Action
receive = const Nothing

initialize :: Maybe Action
initialize = Nothing -- Just NoAction

finalize :: Maybe Action
finalize = Nothing