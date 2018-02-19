module Main exposing (..)

import Html exposing (..)
import Keyboard.Combo


main : Program Never Model Msg
main =
    Html.program
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
    , Keyboard.Combo.combo1 Keyboard.Combo.j CursorDown
    , Keyboard.Combo.combo2 ( Keyboard.Combo.shift, Keyboard.Combo.j ) JoinLines
    ]



-- Init


init : ( Model, Cmd Msg )
init =
    { combos = Keyboard.Combo.init keyboardCombos ComboMsg
    , content = "No combo yet"
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
    | CursorDown
    | JoinLines
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

        CursorDown ->
            { model | content = "Cursor Down" } ! []

        JoinLines ->
            { model | content = "Join Lines" } ! []

        ComboMsg msg ->
            let
                ( updatedKeys, comboCmd ) =
                    Keyboard.Combo.update msg model.combos
            in
                ( { model | combos = updatedKeys }, comboCmd )



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
        , h1 [] [ text "Vim:" ]
        , ul []
            [ li [] [ text "Cursor Down: j" ]
            , li [] [ text "Join lines: shift+j" ]
            ]
        , div []
            [ strong [] [ text "Current command: " ]
            , span [] [ text model.content ]
            ]
        ]
