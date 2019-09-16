module Main where

import Components.Main as MainComponent
import Control.Applicative (pure)
import Control.Bind (bind)
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Console (log)
import Halogen.Aff.Driver (runUI)
import Halogen.Aff.Util (runHalogenAff, awaitBody)
import Web.HTML.HTMLElement (HTMLElement)

main :: Effect Unit
main = runHalogenAff do
    body::HTMLElement <- awaitBody
    --  mainComponent <- runUI MainComponent.component input body
    --  pure ""
    -- where
    --     input = defaultInput

    runUI MainComponent.component defaultInput body


defaultInput :: MainComponent.Input
defaultInput = { length: 8 }
