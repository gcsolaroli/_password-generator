module Components.Random where

--import Control.Applicative (pure)
import Control.Bind (bind)
import Data.Function (($))
import Data.Maybe (Maybe(..), maybe)
--import Data.NaturalTransformation (type (~>))
import Data.Semigroup ((<>))
import Data.Show (show)
import Data.Unit (Unit)
--import Data.Void (Void)
--import Effect.Aff (Aff)
import Effect.Random as Random
import Halogen as Halogen
import Halogen.HTML as HTML
import Halogen.HTML.Events as Events


type State = Maybe Int
data Action = Regenerate
--data Query a = Regenerate a

--   Why are we using Aff rather than Effect?
--  ===========================================
--  For convenience –when it's time to run our UI– Halogen expects an Aff here.
--  It is possible to hoist a component and change the m type, but it's easier if we just use Aff in the first place.
--  Aff can do anything Effect can, so we're not losing out, just admitting more possibilities than we might need.

--  hoist => https://pursuit.purescript.org/packages/purescript-halogen/3.1.3/docs/Halogen.Component#v:hoist
--  Changes the component's m type. A use case for this would be to interpret some Free monad as Aff so the component can be used with runUI.

-- random :: Halogen.Component HTML.HTML Query Unit Void Aff
-- random = Halogen.component {
component :: forall q i o m. Halogen.Component HTML.HTML q i o m
component = Halogen.mkComponent {
        initialState,
        render,
        eval: Halogen.mkEval $ Halogen.defaultEval { handleAction = handleAction }
    }

    where

    -- initialState :: State
    initialState :: forall i. i -> State
    initialState _ = Nothing

    -- render :: State -> Halogen.ComponentHTML Query
    render :: forall m. State -> Halogen.ComponentHTML Action () m
    render state =
        let
            value = maybe "No number generated yet" show state
        in
            HTML.div [] [
                HTML.h1 [] [HTML.text "Random number"],
                HTML.p  [] [HTML.text ("Current value: " <> value)],
                HTML.button [ Events.onClick \_ -> Just Regenerate] [ HTML.text "Generate new number" ]
            ]

    -- eval :: Query ~> Halogen.ComponentHTML Action Unit m
    -- eval = case _ of
    --     Regenerate next -> do
    --         --  liftEffect => https://pursuit.purescript.org/packages/purescript-effect/2.0.0/docs/Effect.Class#v:liftEffect
    --         --  `liftEffect` can be used in any appropriate monad transformer stack to lift an action of type `Effect a` into the monad.
    --         newNumber <- Halogen.liftEffect (Random.randomInt 0 255)
    --         Halogen.put (Just newNumber)
    --         pure next

    handleAction ∷ forall o m. Action → Halogen.HalogenM State Action () o m Unit
    handleAction = case _ of
        Regenerate -> do
            newNumber <- Halogen.liftEffect (Random.randomInt 0 255)
            Halogen.modify_ \st -> (Just newNumber)