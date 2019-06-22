module State.PasswordSettings (PasswordSettings, Password(..), PasswordLength, PasswordStrength(..), PasswordCharset(..)) where

import Data.Either (Either)
import Data.Eq (class Eq)
import Data.Set (Set)
import Data.Show (class Show)

data PasswordStrength = Weak | Strong | VeryStrong
passwordStrengthBits :: PasswordStrength -> Int
passwordStrengthBits s = case s of
    Weak        ->  64
    Strong      -> 128
    VeryStrong  -> 256

newtype Password = Password String
instance showPassword :: Show Password where show (Password password) = password

newtype PasswordLength = PasswordLength Int

data PasswordCharset = UppercaseLetters | LowercaseLetters | Digits | Space | WeirdCharacters
charsetValues :: PasswordCharset -> String
charsetValues passwordCharset = case passwordCharset of
    UppercaseLetters -> "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    LowercaseLetters -> "abcdefghiJklmnopqrstuvwxyz"
    Digits           -> "0123456789"
    Space            -> " "
    WeirdCharacters  -> "~`!@#$%^&*()-_=+,.<>/?[]{}\\|:;'\""

instance eqPasswordCharset :: Eq PasswordCharset where
    eq UppercaseLetters UppercaseLetters    = true
    eq LowercaseLetters LowercaseLetters    = true
    eq Digits           Digits              = true
    eq Space            Space               = true
    eq WeirdCharacters  WeirdCharacters     = true
    eq _                _                   = false

type PasswordSettings = {
     strength   :: Either PasswordStrength PasswordLength,
     characters :: Either (Set PasswordCharset) String
}