{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( elmPage
    ) where

import Text.Blaze.Html5 as H
    ( (!), body, div, docTypeHtml, head, script, title, text, textValue, link )
import Text.Blaze.Html (Html)
import Text.Blaze.Html5.Attributes as A
import Data.Text (Text)

elmPage :: Text -> Text -> Html
elmPage initTitle componentName =
    docTypeHtml $ do
        H.head $ do
            H.title $ H.text initTitle
            H.link ! A.rel "stylesheet" 
                   ! A.href "/css/app.css"
        body $ do
            H.div ! A.id "main" 
                  $ ""
            script ! src (H.textValue $ "/scripts/" <> componentName <> ".min.js")
                   $ ""
            script $ H.text $ "var app = Elm." <> componentName <> ".init({ node: document.querySelector('#main') })"
