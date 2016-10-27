module Keyboard.Combo
    exposing
        ( KeyCombo
        , Model
        , Msg(..)
        , update
        , init
        , subscriptions
          --, fromCombo
        , combo1
        , combo2
        , combo3
        , super
        , command
        , shift
        , control
        , alt
        , option
        , a
        , s
        )

{-| Provides helpers to call messages on the give keyboard combinations

@docs KeyCombo, Model, Msg, update, init, subscriptions

## Combo Helpers

@docs combo1, combo2, combo3

## Modifiers

@docs super, command, shift, control, alt, option


## Letters

@docs a, s
-}

import Keyboard.Extra


-- Model


{-| -}
type alias Model msg =
    { keys : Keyboard.Extra.Model
    , combos : List (KeyCombo msg)
    , toMsg : Msg -> msg
    }


{-| -}
type KeyCombo msg
    = KeyCombo Keyboard.Extra.Key msg
    | KeyCombo2 Keyboard.Extra.Key Keyboard.Extra.Key msg
    | KeyCombo3 Keyboard.Extra.Key Keyboard.Extra.Key Keyboard.Extra.Key msg



-- Init


{-| -}
init : (Msg -> msg) -> List (KeyCombo msg) -> Model msg
init msg combos =
    { keys = Keyboard.Extra.init |> fst
    , combos = combos
    , toMsg = msg
    }


{-| -}
subscriptions : Model parentMsg -> Sub parentMsg
subscriptions model =
    mapMsgFromCombos model <| Sub.map KeyboardMsg Keyboard.Extra.subscriptions



-- Update


{-| -}
type Msg
    = KeyboardMsg Keyboard.Extra.Msg
    | Reset


{-| -}
update : Msg -> Model msg -> Model msg
update msg model =
    case msg of
        KeyboardMsg msg ->
            let
                updatedKeys =
                    Keyboard.Extra.update msg model.keys
                        |> fst
            in
                { model | keys = updatedKeys }

        Reset ->
            init model.toMsg model.combos



-- Combo helpers


{-| -}
combo1 : Keyboard.Extra.Key -> msg -> KeyCombo msg
combo1 key msg =
    KeyCombo key msg


{-| -}
combo2 : ( Keyboard.Extra.Key, Keyboard.Extra.Key ) -> msg -> KeyCombo msg
combo2 ( key1, key2 ) msg =
    KeyCombo2 key1 key2 msg


{-| -}
combo3 : ( Keyboard.Extra.Key, Keyboard.Extra.Key, Keyboard.Extra.Key ) -> msg -> KeyCombo msg
combo3 ( key1, key2, key3 ) msg =
    KeyCombo3 key1 key2 key3 msg



-- Modifier Keys


{-| -}
super : Keyboard.Extra.Key
super =
    Keyboard.Extra.Super


{-| -}
command : Keyboard.Extra.Key
command =
    super


{-| -}
shift : Keyboard.Extra.Key
shift =
    Keyboard.Extra.Shift


{-| -}
alt : Keyboard.Extra.Key
alt =
    Keyboard.Extra.Alt


{-| -}
option : Keyboard.Extra.Key
option =
    alt


{-| -}
control : Keyboard.Extra.Key
control =
    Keyboard.Extra.Control



-- English letters


{-| -}
a : Keyboard.Extra.Key
a =
    Keyboard.Extra.CharA


{-| -}
s : Keyboard.Extra.Key
s =
    Keyboard.Extra.CharS



-- Utils


arePressed : Keyboard.Extra.Model -> List Keyboard.Extra.Key -> Bool
arePressed keyTracker keysPressed =
    List.all
        (\key -> Keyboard.Extra.isPressed key keyTracker)
        keysPressed


matchesCombo : Model msg -> Maybe (KeyCombo msg)
matchesCombo model =
    find (\combo -> arePressed model.keys <| keyList combo) model.combos


keyList : KeyCombo msg -> List Keyboard.Extra.Key
keyList combo =
    case combo of
        KeyCombo key msg ->
            [ key ]

        KeyCombo2 key1 key2 msg ->
            [ key1, key2 ]

        KeyCombo3 key1 key2 key3 msg ->
            [ key1, key2, key3 ]


mapMsgFromCombos : Model msg -> Sub Msg -> Sub msg
mapMsgFromCombos model sub =
    matchesCombo model
        |> Maybe.map
            (\combo ->
                case combo of
                    KeyCombo key msg ->
                        msg

                    KeyCombo2 key1 key2 msg ->
                        msg

                    KeyCombo3 key1 key2 key3 msg ->
                        msg
            )
        |> Maybe.map
            (\msg ->
                Sub.batch
                    [ Sub.map (\_ -> msg) sub
                    , Sub.map (\_ -> model.toMsg Reset) sub
                    ]
            )
        |> Maybe.withDefault (Sub.map model.toMsg sub)


find : (a -> Bool) -> List a -> Maybe a
find predicate list =
    case list of
        [] ->
            Nothing

        first :: rest ->
            if predicate first then
                Just first
            else
                find predicate rest
