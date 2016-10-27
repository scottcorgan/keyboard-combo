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


combos : List (Keyboard.Combo.KeyCombo Msg)
combos =
    [ Keyboard.Combo.combo2 ( Keyboard.Combo.control, Keyboard.Combo.s ) Save
    , Keyboard.Combo.combo2 ( Keyboard.Combo.control, Keyboard.Combo.a ) SelectAll
    ]



-- Init


init : ( Model, Cmd Msg )
init =
    let
        m =
            Keyboard.Combo.init ComboMsg []
    in
        { combos =
            Keyboard.Combo.init ComboMsg combos
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
    | ComboMsg Keyboard.Combo.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Save ->
            { model | content = "Saved" } ! []

        SelectAll ->
            { model | content = "Select All" } ! []

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
            ]
        , div []
            [ strong [] [ text "Current command: " ]
            , span [] [ text model.content ]
            ]
        ]
