{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE TypeOperators     #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE OverloadedStrings #-}

module Api (Number, NumberApi, numberApi, the_number, VariableApi, variableApi, the_variable, MathApi, mathApi) where

import Control.Lens
import Data.Aeson hiding (Number)
import Servant
import GHC.Generics

import Test.QuickCheck (Gen, choose, elements, listOf, listOf1, resize)
import Test.QuickCheck.Arbitrary

-- A record, called Number, with an integer field called 'number'
-- The 'deriving' clause asks the compiler to create some helpful
-- functions for us: equality comparison, string and JSON conversion
data Number = Number { number :: Integer }
  deriving (Eq, Show, Generic, ToJSON, FromJSON)

data Variable = Variable { var :: String }
  deriving (Eq, Show, Generic, ToJSON, FromJSON)

the_number :: Integer -> Number
the_number x = Number x

the_variable :: String -> Variable
the_variable x = Variable x

-- We can:
--   get a number at /number
--   get a list of numbers at /numbers
type NumberApi =
       "number"  :> Get '[JSON] Number
  :<|> "numbers" :> Get '[JSON] [Number]

-- We can:
--    get the variable "x" at /variable
type VariableApi =
  "variable" :> Get '[JSON] Variable

type MathApi = NumberApi :<|> VariableApi

-- We could ask the compiler to generate instances for Arbitrary as well,
-- but it's nice to have control over what we do here
instance Arbitrary Number where
  arbitrary = do
    rando <- choose (0, 1000)
    return $ Number rando

genWord :: Gen String
genWord = listOf1 (choose ('a', 'z'))

instance Arbitrary Variable where
  arbitrary = do
    word <- genWord
    return $ Variable word

-- This is just some boilerplate to help the type system sort
-- some stuff out
numberApi :: Proxy NumberApi
numberApi = Proxy

variableApi :: Proxy VariableApi
variableApi = Proxy

mathApi :: Proxy MathApi
mathApi = Proxy
