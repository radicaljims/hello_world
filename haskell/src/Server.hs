module Server(numberApp, numberServer, mathApp, mockServer) where

import Network.Wai.Middleware.Cors
import Servant
import Servant.Mock

import Api (NumberApi, numberApi, the_number, VariableApi, the_variable, MathApi, mathApi)

-- Here we see interpretations of our API types as servers, both "real" and mock

-- numberServer implements handlers for the API's endpoints,
-- in this case artisan hand-picked numbers
numberServer :: Server NumberApi
numberServer = number :<|> numbers
  where
    number =  return (the_number 5)
    numbers = return [the_number 0, the_number 1, the_number 2, the_number 3]

variableServer :: Server VariableApi
variableServer = variable
  where
    variable = return (the_variable "x")

-- Yes we really can just add the server implementations together, same as we did their types!
mathServer :: Server MathApi
mathServer = numberServer :<|> variableServer

-- mockServer generates random, garbage numbers for the API's endpoints
-- Useful for UI prototyping
-- AND ALSO OMG IT'S JUST A FUNCTION WE HAVE TO CALL ONCE PER API WTF AWESOME
mockServer :: Application
mockServer = simpleCors (serve mathApi $ mock mathApi Proxy)

-- numberApp is just some plumbing
numberApp :: Application
numberApp = serve (Proxy :: Proxy NumberApi) numberServer

-- mots
mathApp :: Application
mathApp = serve (Proxy :: Proxy MathApi) mathServer
