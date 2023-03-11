{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import Lib (elmPage)

import System.Environment (lookupEnv)
import System.Directory (getDirectoryContents)

import Text.Read (readMaybe)

import Control.Monad.Trans
import Data.IORef
import Data.List as L (isPrefixOf)
import qualified Data.Text as T
import Data.Maybe (fromMaybe, mapMaybe)
import Text.Blaze.Html.Renderer.Utf8 (renderHtml)
import Network.Wai.Middleware.Static (staticPolicy, addBase)
import Network.Wai.Middleware.Gzip (gzip, def, GzipFiles (GzipPreCompressed, GzipCompress), gzipFiles)
import Network.Wai.Handler.Warp (run)
import Network.Wai
import Network.HTTP.Types (status200)

data MySession = EmptySession
newtype MyAppState = DummyAppState (IORef Int)
data Handler = Handler {path :: [T.Text], script :: T.Text}

renderElm title component = renderHtml $ elmPage title component

handlerForModule :: T.Text -> Handler
handlerForModule moduleName = Handler { script = moduleName, path = T.split (=='.') (T.toLower moduleName) }

respondHandler :: [T.Text] -> [Handler] -> Handler
respondHandler path handlers = respondHandlerInternal path handlers $ Handler {path = [], script = "Main"}

respondHandlerInternal :: [T.Text] -> [Handler] -> Handler -> Handler
respondHandlerInternal pathToMatch [handler] latestHandler =
    if (path handler `L.isPrefixOf` pathToMatch) && (path latestHandler `L.isPrefixOf` path handler) then
        handler
    else
        latestHandler

respondHandlerInternal pathToMatch (handler:otherHandlers) latestHandler =
    respondHandlerInternal pathToMatch otherHandlers $
        if (path handler `L.isPrefixOf` pathToMatch) && (path latestHandler `L.isPrefixOf` path handler) then
            handler
        else 
            latestHandler

main :: IO ()
main =
    do port <- lookupEnv "PORT"
       let portNum = fromMaybe 8080 (port >>= readMaybe)
       pageScripts <- getDirectoryContents "static/scripts"
       putStrLn $ "Listening on " <> show portNum
       run portNum $ gzip def {gzipFiles = GzipPreCompressed GzipCompress} $ staticPolicy (addBase "static") $ app (mapMaybe (T.stripSuffix ".min.js" . T.pack) pageScripts)

app :: [T.Text] -> Request -> (Response -> b) -> b
app scripts req respond = respond $
    let handlers = map handlerForModule scripts
        handler = respondHandler (pathInfo req) handlers
    in responseLBS status200 [] $ renderElm (script handler) (script handler)