{-# LANGUAGE OverloadedStrings #-}
import Api (numberApi)
import Server (numberServer)
import Test.Hspec
import Test.QuickCheck.Instances
import Servant.QuickCheck
import Test.QuickCheck (Arbitrary(..))

-- Here we see an interpretation of our server's API as a series of automated tests

-- These tests are run against every endpoint we have declared in our API and
-- enforce global behaviorial properties

-- You could of course write tests to target specific endpoints, but I'm lazy

-- Servant-QuickCheck also comes with a very handy predicate to compare the results
-- of two different services. Very handy when refactoring!

spec :: Spec
spec = describe "check number api" $ do
  let ioServer = do
        return $ numberServer

  it "should not return 500s" $ do
    withServantServer numberApi ioServer $ \url ->
      serverSatisfies numberApi url defaultArgs (not500 <%> mempty)

  it "should not return top-level json" $ do
    withServantServer numberApi ioServer $ \url ->
      serverSatisfies numberApi url defaultArgs (onlyJsonObjects <%> mempty)

  it "should return valid locations for 201" $ do
    withServantServer numberApi ioServer $ \url ->
      serverSatisfies numberApi url defaultArgs (createContainsValidLocation <%> mempty)

main :: IO ()
main = do
  hspec spec
