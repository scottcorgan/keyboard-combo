module Main exposing (..)

import Browser
import Html exposing (..)
import Keyboard.Combo
    exposing
        ( global
        , control
        , alt
        , shift
        , press
        )
import Keyboard.Key exposing (a, s, e)


main : Program {} Model Msg
main =
    Browser.document
        { subscriptions = subscriptions
        , init = \_ -> ( { content = "Nothing pressed" }, Cmd.none )
        , update = update
        , view = view
        }



-- keyboardCombos : List (Keyboard.Combo.KeyCombo Msg)
-- keyboardCombos =
--     [ Keyboard.Combo.combo2 ( Keyboard.Combo.control, Keyboard.Combo.s ) Save
--     , Keyboard.Combo.combo2 ( Keyboard.Combo.control, Keyboard.Combo.a ) SelectAll
--     , Keyboard.Combo.combo3 ( Keyboard.Combo.control, Keyboard.Combo.alt, Keyboard.Combo.e ) RandomThing
--     ]
-- Init


subscriptions : Model -> Sub Msg
subscriptions model =
    -- Keyboard.Combo.inputs
    -- Keyboard.Combo.all
    -- Keyboard.Combo.custom
    global
        [ press [ control, shift ] a SelectAll
        , press [ control, shift ] s Save
        , press [ control, alt ] e RandomThing
        ]



-- Model


type alias Model =
    { content : String }



-- Update


type Msg
    = Save
    | SelectAll
    | RandomThing
    | Reset


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Save ->
            ( { model | content = "Saved" }, Cmd.none )

        SelectAll ->
            ( { model | content = "Select All" }, Cmd.none )

        RandomThing ->
            ( { model | content = "Random Thing" }, Cmd.none )

        Reset ->
            ( { model | content = "Nothing Press" }, Cmd.none )



-- View


view : Model -> Browser.Document Msg
view model =
    { title = ""
    , body =
        [ div []
            [ h1 [] [ text "Available Key Commands:" ]
            , ul []
                [ li [] [ text "Save: Ctrl+Shift+s" ]
                , li [] [ text "Select All: Ctrl+Shift+a" ]
                , li [] [ text "Random Thing: Ctrl+Alt+e" ]
                ]
            , div []
                [ strong [] [ text "Current command: " ]
                , span [] [ text model.content ]
                ]
            ]
        ]
    }
