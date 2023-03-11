# Warp & Elm Full-Stack

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template/NSeGz_?referralCode=Y68pBw)

This is a basic full-stack app example using Haskell, [Warp](https://hackage.haskell.org/package/warp), and [Elm](https://elm-lang.org).

## Developing
You will need:
- [Haskell Stack](https://docs.haskellstack.org/en/stable/)
- [Elm](https://elm-lang.org)
- [esbuild](https://esbuild.github.io/) (in your PATH)

To run, just use `stack run`.

Elm files are compiled and minified as part of the Haskell build process (see `Setup.hs`); right now, however, they are not tracked for changes, so if you changed an Elm file without changing a Haskell file, you will need to delete `.stack-work` before rebuilding in order to make sure that the Elm is actually rebuilt.

## Adding a Page
To add a page, first create an Elm module, e.g.:

```elm
module MyPage exposing (..)


import Browser
import Html exposing (Html, div, text)

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
  div [] [text "Hello!"]
```

Then, add it to the `buildElm` list in `Setup.hs`:

```haskell
...
postBuild = buildElm ["Main", "About", "MyPage"]
...
```

And you're done!
