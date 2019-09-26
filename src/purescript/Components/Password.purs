module Components.Password where

import Control.Applicative (pure)
import Control.Category (identity)
-- import Control.Semigroupoid ((<<<))
-- import Data.Eq (class Eq)
import Data.Function (($), const)
import Data.Maybe (Maybe(..))
-- import Data.Ord (class Ord)
import Data.Semigroup ((<>))
-- import Data.Semiring ((+))
-- import Data.Show (show)
-- import Data.Symbol (SProxy(..))
import Data.Unit (Unit, unit)
import Effect.Aff.Class (class MonadAff)
import Halogen as Halogen
import Halogen.HTML as HTML
import Halogen.HTML.Properties as HTML.Properties

type    Surface    = HTML.HTML
data    Action     = NoAction
data    Query a    = GetSettings a
type    Input      = String
data    Output     = UpdatedPassword String
type    State      = String
type    Slot = Halogen.Slot Query Output
type    Slots = ()

initialState :: Input -> State
initialState = identity

component :: forall m. MonadAff m => Halogen.Component Surface Query Input Output m
component = Halogen.mkComponent {
    initialState,   -- :: Input -> State
    render,         -- :: State -> Surface (ComponentSlot Surface Slots m Action) Action
    eval: Halogen.mkEval $ Halogen.defaultEval {
        handleAction = handleAction,    --  handleAction    :: forall m. MonadAff m => Action → Halogen.HalogenM State Action Slots Output m Unit
        handleQuery  = handleQuery,     --  handleQuery     :: forall m a. Query a -> Halogen.HalogenM State Action Slots Output m (Maybe a)
        receive      = receive,         --  receive         :: Input -> Maybe Action
        initialize   = initialize,      --  initialize      :: Maybe Action
        finalize     = finalize         --  finalize        :: Maybe Action
    }
                    -- :: HalogenQ Query Action Input ~> HalogenM State Action Slots Output m
}

render :: forall m. {-MonadAff m =>-} State -> Halogen.ComponentHTML Action Slots m
render (password) = HTML.div [HTML.Properties.class_ (Halogen.ClassName "password")] [
    HTML.h1  [] [HTML.text ("<password>: " <> password)]
]

handleAction ∷ forall m. MonadAff m => Action → Halogen.HalogenM State Action Slots Output m Unit
handleAction = case _ of
    NoAction ->
        pure unit

handleQuery :: forall m a. Query a -> Halogen.HalogenM State Action Slots Output m (Maybe a)
handleQuery = const (pure Nothing)

receive :: Input -> Maybe Action
receive = const Nothing

initialize :: Maybe Action
initialize = Just NoAction

finalize :: Maybe Action
finalize = Nothing