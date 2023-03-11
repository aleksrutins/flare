module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html exposing (span)
import Html exposing (h1)
import Html.Attributes exposing (class)
import Html exposing (p)
import Html.Attributes exposing (style)
import Html.Attributes exposing (href)
import Html exposing (a)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model = Int


init : Model
init =
  0



-- UPDATE


type Msg
  = Increment
  | Decrement


update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1



-- VIEW


view : Model -> Html Msg
view model =
  div [class "container"]
    [ h1 [class "heading"] [text "Warp + Elm Full-Stack"]
    , a [style "display" "block", style "align-self" "center", style "margin-bottom" "10px", href "/about"] [text "Another Page"]
    , div [class "counter-container"] [
        button [ onClick Increment ] [ text "Increment" ]
      , p [style "font-family" "monospace"] [ text (String.fromInt model) ]
      , button [ onClick Decrement ] [ text "Decrement" ]
      ]
    ]