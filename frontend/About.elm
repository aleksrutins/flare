module About exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import Html exposing (h1)
import Html exposing (a)
import Html.Attributes exposing (href)
import Html exposing (p)
import Html exposing (h2)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model = ()


init : Model
init =
  ()



-- UPDATE


type alias Msg = ()

update : Msg -> Model -> Model
update _ model =
  model



-- VIEW


view : Model -> Html Msg
view _ =
  div [class "container"]
    [ h1 [class "heading"] [text "About"]
    , p [] [ text "This is an example app using "
           , a [href "https://hackage.haskell.org/package/warp"] [text "Warp"]
           , text " (the server library behind "
           , a [href "https://yesodweb.com"] [text "Yesod"]
           , text ") and "
           , a [href "https://elm-lang.org"] [text "Elm"]
           , text ". Learn more on "
           , a [href "https://github.com/aleksrutins/elm-haskell-fullstack"] [text "GitHub"]
           , text "."]
    , a [href "/"] [text "Back to Home"]
     ]