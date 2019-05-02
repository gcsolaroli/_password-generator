module Crypto where

import Effect (Effect)
import Node.Buffer (Buffer)

foreign import _getRandomValues :: Int -> Effect Buffer

randomBytes :: Int -> Effect Buffer
randomBytes = _getRandomValues
