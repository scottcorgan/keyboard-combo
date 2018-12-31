module Main exposing (Model, Msg(..), main, subscriptions, update, view)

import Browser
import Html exposing (..)
import Keyboard.Combo
    exposing
        ( alt
        , control
        , global
        , press
        , shift
        )
import Keyboard.Key exposing (a, e, s)


main : Program {} Model Msg
main =
    Browser.document
        { subscriptions = subscriptions
        , init = \_ -> ( { content = "Nothing pressed" }, Cmd.none )
        , update = update
        , view = view
        }


subscriptions : Model -> Sub Msg
subscriptions model =
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
