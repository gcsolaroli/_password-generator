module Main where

import Control.Applicative (pure)
import Control.Bind (bind)
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Console (log)
import Halogen.Aff.Util (runHalogenAff, awaitBody)
import Halogen.Aff.Driver (runUI)

main :: Effect Unit
main = runHalogenAff do
--    let input = unit    --  eval "gcsolaroli"
    --  The element we pass in should already be present in the DOM, and should be empty.
    --  If either of these conditions are not met then strange things may occur - the behaviour is unspecified.
    body <- awaitBody

    -- button <- runUI Button.button unit body
    -- button.subscribe $ consumer \(Button.Toggled newState) -> do
    --      log $ "Button was toggled to: " <> show newState
    --      pure Nothing
    -- button.query $ Halogen.action $ Button.Toggle
    -- button.query $ Halogen.action $ Button.Toggle

    -- randomComponent <- runUI Random.random unit body
    -- randomComponent.query $ Halogen.action $ Random.Regenerate

    -- ajaxComponent <- runUI GitHubAjax.ajax unit body
    -- ajaxComponent.query $ Halogen.action $ GitHubAjax.SetUsername "gcsolaroli"
    -- ajaxComponent.query $ Halogen.action $ GitHubAjax.MakeRequest

    -- container           <- runUI Container.component unit body
    -- displayContainer    <- runUI DisplayContainer.component unit body
    -- multiComponents     <- runUI MultiSubComponentsContainer.component unit body
    pure ""
