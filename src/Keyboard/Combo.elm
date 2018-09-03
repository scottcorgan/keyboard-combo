module Keyboard.Combo exposing (..)

import Browser.Events
import Json.Decode as Decode exposing (Decoder, field, at, string, bool)
import Keyboard.Key as Key exposing (Key)


type alias Config msg =
    { subscription : Subscription
    , combos : List (Combo msg)
    }


type Event
    = Press
    | Down
    | Up


type Subscription
    = Global


type Modifier
    = Alt
    | Ctrl
    | Super
    | Shift


type alias KeyConfig =
    { key : Key
    , modifiers : List Modifier
    , event : Event
    }


type Combo msg
    = Combo ( KeyConfig, msg )



-- Decoders


type alias DecodedModifiers =
    { alt : Bool
    , ctrl : Bool
    , shift : Bool
    , super : Bool
    }


globalDecoder : List (Combo msg) -> Decoder msg
globalDecoder combos =
    at [ "target", "nodeName" ] Decode.string
        |> Decode.andThen (ignoreNodes combos)


ignoreNodes : List (Combo msg) -> String -> Decoder msg
ignoreNodes combos tag =
    case String.toLower tag of
        "input" ->
            Decode.fail "ignore input"

        "textarea" ->
            Decode.fail "ignore textarea"

        _ ->
            comboDecoder combos


comboDecoder : List (Combo msg) -> Decoder msg
comboDecoder combos =
    Decode.map2 (findComboMsg combos)
        Key.decodeKey
        decodeModifiers
        |> Decode.andThen
            (\maybeMsg ->
                case maybeMsg of
                    Just msg ->
                        Decode.succeed msg

                    _ ->
                        Decode.fail "no matching combination"
            )


decodeModifiers : Decoder DecodedModifiers
decodeModifiers =
    Decode.map4 DecodedModifiers
        (field "altKey" bool)
        (field "ctrlKey" bool)
        (field "shiftKey" bool)
        (field "metaKey" bool)


findComboMsg : List (Combo msg) -> Key -> DecodedModifiers -> Maybe msg
findComboMsg combos key modifiers =
    let
        matchesModifiers keyConfig =
            List.all (\modifier -> isModifierActive modifier modifiers) keyConfig.modifiers

        matchesCombo =
            (\(Combo ( keyConfig, _ )) ->
                case
                    ( key == keyConfig.key
                    , matchesModifiers keyConfig
                    )
                of
                    ( True, True ) ->
                        True

                    _ ->
                        False
            )
    in
        case find matchesCombo combos of
            Just (Combo ( _, msg )) ->
                Just msg

            _ ->
                Nothing


isModifierActive : Modifier -> DecodedModifiers -> Bool
isModifierActive modifier modifiers =
    case modifier of
        Alt ->
            modifiers.alt

        Ctrl ->
            modifiers.ctrl

        Shift ->
            modifiers.shift

        Super ->
            modifiers.super



-- Subscriptions


global : List (Combo msg) -> Sub msg
global combos =
    -- TODO: group by event event (press, up, etc)
    Browser.Events.onKeyPress (globalDecoder combos)



-- Events


press : List Modifier -> Key -> msg -> Combo msg
press modifiers key msg =
    Combo
        ( { key = key
          , modifiers = modifiers
          , event = Press
          }
        , msg
        )


up : List Modifier -> Key -> msg -> Combo msg
up modifiers key msg =
    Combo
        ( { key = key
          , modifiers = modifiers
          , event = Up
          }
        , msg
        )



-- Modifiers


alt : Modifier
alt =
    Alt


control : Modifier
control =
    Ctrl


shift : Modifier
shift =
    Shift


super : Modifier
super =
    Super



-- Utils


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
