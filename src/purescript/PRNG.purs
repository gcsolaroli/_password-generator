module PRNG where

import Effect (Effect)
import Node.Buffer (Buffer)

foreign import nativeGenerateRandomNumber :: Int -> Effect Buffer

randomBytes :: Int -> Effect Buffer
randomBytes = nativeGenerateRandomNumber
