module Main where

--import Components.Main as MainComponent
import Components.Main as Components.Main
--import Control.Applicative (pure)
import Control.Bind (bind)
import Data.Unit (Unit)
import Effect (Effect)
--import Effect.Console (log)
import Halogen.Aff.Util (runHalogenAff, awaitBody)
import Halogen.VDom.Driver (runUI)
import Web.HTML.HTMLElement (HTMLElement)

main :: Effect Unit
main = runHalogenAff do
    body::HTMLElement <- awaitBody
    --  mainComponent <- runUI MainComponent.component input body
    --  pure ""
    -- where
    --     input = defaultInput

    runUI Components.Main.component defaultInput body


defaultInput :: Components.Main.Input
defaultInput = { length: 8 }
