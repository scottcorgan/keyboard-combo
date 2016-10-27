# Keyboard Combo

Handle keyboard key combinations with type safety in Elm

**Note:** Not every key is implemented yet. Please open a PR if one is missing.

## Usage

Usage example taken from [Example in _examples_ directory](https://github.com/scottcorgan/keyboard-combo/tree/master/examples)

```elm
module Main exposing (..)

import Html exposing (..)
import Html.App
import Keyboard.Combo


main : Program Never
main =
    Html.App.program
        { subscriptions = subscriptions
        , init = init
        , update = update
        , view = view
        }


keyboardCombos : List (Keyboard.Combo.KeyCombo Msg)
keyboardCombos =
    [ Keyboard.Combo.combo2 ( Keyboard.Combo.control, Keyboard.Combo.s ) Save
    , Keyboard.Combo.combo2 ( Keyboard.Combo.control, Keyboard.Combo.a ) SelectAll
    , Keyboard.Combo.combo3 ( Keyboard.Combo.control, Keyboard.Combo.alt, Keyboard.Combo.e ) RandomThing
    ]



-- Init


init : ( Model, Cmd Msg )
init =
    { combos = Keyboard.Combo.init ComboMsg keyboardCombos
    , content = "Not combo yet"
    }
        ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Keyboard.Combo.subscriptions model.combos



-- Model


type alias Model =
    { combos : Keyboard.Combo.Model Msg
    , content : String
    }



-- Update


type Msg
    = Save
    | SelectAll
    | RandomThing
    | ComboMsg Keyboard.Combo.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Save ->
            { model | content = "Saved" } ! []

        SelectAll ->
            { model | content = "Select All" } ! []

        RandomThing ->
            { model | content = "Random Thing" } ! []

        ComboMsg msg ->
            let
                updatedCombos =
                    Keyboard.Combo.update msg model.combos
            in
                { model | combos = updatedCombos } ! []



-- View


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Available Key Commands:" ]
        , ul []
            [ li [] [ text "Save: Ctrl+s" ]
            , li [] [ text "Select All: Ctrl+a" ]
            , li [] [ text "Random Thing: Ctrl+Alt+e" ]
            ]
        , div []
            [ strong [] [ text "Current command: " ]
            , span [] [ text model.content ]
            ]
        ]

```
