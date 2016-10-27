module Keyboard.Combo
    exposing
        ( KeyCombo
        , Model
        , Msg
        , update
        , init
        , subscriptions
        , combo1
        , combo2
        , combo3
        , combo4
        , super
        , command
        , shift
        , control
        , alt
        , option
        , enter
        , tab
        , escape
        , space
        , a
        , b
        , c
        , d
        , e
        , f
        , g
        , h
        , i
        , j
        , k
        , l
        , m
        , n
        , o
        , p
        , q
        , r
        , s
        , t
        , u
        , v
        , w
        , x
        , y
        , z
        , zero
        , one
        , two
        , three
        , four
        , five
        , six
        , seven
        , eight
        , nine
        )

{-| Provides helpers to call messages on the given key combinations

## Types

@docs Model, Msg, KeyCombo

## Setup

    import Keyboard.Combo

    type alias Model =
        { combos : Keyboard.Combo.Model Msg }

    type Msg
        = Save
        | SaveAll
        | RandomThing
        | ComboMsg Keyboard.Combo.Msg

    keyboardCombos : List (Keyboard.Combo.KeyCombo Msg)
    keyboardCombos =
        [ Keyboard.Combo.combo2 ( Keyboard.Combo.control, Keyboard.Combo.s ) Save
        , Keyboard.Combo.combo2 ( Keyboard.Combo.control, Keyboard.Combo.a ) SelectAll
        , Keyboard.Combo.combo3 ( Keyboard.Combo.control, Keyboard.Combo.alt, Keyboard.Combo.e ) RandomThing
        ]

    init : ( Model, Cmd Msg )
    init =
        { combos = Keyboard.Combo.init ComboMsg keyboardCombos } ! []


    subscriptions : Model -> Sub Msg
    subscriptions model =
        Keyboard.Combo.subscriptions model.combos

@docs init, subscriptions, update

## Combo Helpers

    import Keyboard.Combo

    type Msg
        = Save
        | SaveAll
        | RandomThing

    keyboardCombos : List (Keyboard.Combo.KeyCombo Msg)
    keyboardCombos =
        [ Keyboard.Combo.combo2 ( Keyboard.Combo.control, Keyboard.Combo.s ) Save
        , Keyboard.Combo.combo2 ( Keyboard.Combo.control, Keyboard.Combo.a ) SelectAll
        , Keyboard.Combo.combo3 ( Keyboard.Combo.control, Keyboard.Combo.alt, Keyboard.Combo.e ) RandomThing
        ]

@docs combo1, combo2, combo3, combo4

## Modifiers

@docs super, command, shift, control, alt, option, enter, tab, escape, space


## Letters

@docs a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z

## Number Helpers

@docs zero, one, two, three, four, five, six, seven, eight, nine
-}

import Keyboard.Extra


-- Model


{-| Internal state that keeps track of keys currently pressed and key combos
-}
type alias Model msg =
    { keys : Keyboard.Extra.Model
    , combos : List (KeyCombo msg)
    , toMsg : Msg -> msg
    }


{-| Combo length types
-}
type KeyCombo msg
    = KeyCombo Keyboard.Extra.Key msg
    | KeyCombo2 Keyboard.Extra.Key Keyboard.Extra.Key msg
    | KeyCombo3 Keyboard.Extra.Key Keyboard.Extra.Key Keyboard.Extra.Key msg
    | KeyCombo4 Keyboard.Extra.Key Keyboard.Extra.Key Keyboard.Extra.Key Keyboard.Extra.Key msg



-- Init


{-| Initialize the module
-}
init : (Msg -> msg) -> List (KeyCombo msg) -> Model msg
init msg combos =
    { keys = Keyboard.Extra.init |> fst
    , combos = combos
    , toMsg = msg
    }


{-| Subscribe to module key events
-}
subscriptions : Model parentMsg -> Sub parentMsg
subscriptions model =
    mapMsgFromCombos model <| Sub.map KeyboardMsg Keyboard.Extra.subscriptions



-- Update


{-| Internal update messages
-}
type Msg
    = KeyboardMsg Keyboard.Extra.Msg
    | Reset


{-| Update the internal model
-}
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


{-| Helper to define a key combo of one key
-}
combo1 : Keyboard.Extra.Key -> msg -> KeyCombo msg
combo1 key msg =
    KeyCombo key msg


{-| Helper to define a key combo of two keys
-}
combo2 : ( Keyboard.Extra.Key, Keyboard.Extra.Key ) -> msg -> KeyCombo msg
combo2 ( key1, key2 ) msg =
    KeyCombo2 key1 key2 msg


{-| Helper to define a key combo of three keys
-}
combo3 : ( Keyboard.Extra.Key, Keyboard.Extra.Key, Keyboard.Extra.Key ) -> msg -> KeyCombo msg
combo3 ( key1, key2, key3 ) msg =
    KeyCombo3 key1 key2 key3 msg


{-| Helper to define a key combo of four keys
-}
combo4 : ( Keyboard.Extra.Key, Keyboard.Extra.Key, Keyboard.Extra.Key, Keyboard.Extra.Key ) -> msg -> KeyCombo msg
combo4 ( key1, key2, key3, key4 ) msg =
    KeyCombo4 key1 key2 key3 key4 msg



-- Modifier Keys


{-| Helper for super key
-}
super : Keyboard.Extra.Key
super =
    Keyboard.Extra.Super


{-| Helper for macOS command key
-}
command : Keyboard.Extra.Key
command =
    super


{-| Helper for shift key
-}
shift : Keyboard.Extra.Key
shift =
    Keyboard.Extra.Shift


{-| Helper for alt key
-}
alt : Keyboard.Extra.Key
alt =
    Keyboard.Extra.Alt


{-| Helper for macOS option key
-}
option : Keyboard.Extra.Key
option =
    alt


{-| Helper for control key
-}
control : Keyboard.Extra.Key
control =
    Keyboard.Extra.Control


{-| Helper for enter key
-}
enter : Keyboard.Extra.Key
enter =
    Keyboard.Extra.Enter


{-| Helper for tab key
-}
tab : Keyboard.Extra.Key
tab =
    Keyboard.Extra.Tab


{-| Helper for escape key
-}
escape : Keyboard.Extra.Key
escape =
    Keyboard.Extra.Escape


{-| Helper for space key
-}
space : Keyboard.Extra.Key
space =
    Keyboard.Extra.Space



-- Letter helpers


{-| -}
a : Keyboard.Extra.Key
a =
    Keyboard.Extra.CharA


{-| -}
b : Keyboard.Extra.Key
b =
    Keyboard.Extra.CharB


{-| -}
c : Keyboard.Extra.Key
c =
    Keyboard.Extra.CharC


{-| -}
d : Keyboard.Extra.Key
d =
    Keyboard.Extra.CharD


{-| -}
e : Keyboard.Extra.Key
e =
    Keyboard.Extra.CharE


{-| -}
f : Keyboard.Extra.Key
f =
    Keyboard.Extra.CharF


{-| -}
g : Keyboard.Extra.Key
g =
    Keyboard.Extra.CharG


{-| -}
h : Keyboard.Extra.Key
h =
    Keyboard.Extra.CharH


{-| -}
i : Keyboard.Extra.Key
i =
    Keyboard.Extra.CharI


{-| -}
j : Keyboard.Extra.Key
j =
    Keyboard.Extra.CharJ


{-| -}
k : Keyboard.Extra.Key
k =
    Keyboard.Extra.CharK


{-| -}
l : Keyboard.Extra.Key
l =
    Keyboard.Extra.CharL


{-| -}
m : Keyboard.Extra.Key
m =
    Keyboard.Extra.CharM


{-| -}
n : Keyboard.Extra.Key
n =
    Keyboard.Extra.CharN


{-| -}
o : Keyboard.Extra.Key
o =
    Keyboard.Extra.CharO


{-| -}
p : Keyboard.Extra.Key
p =
    Keyboard.Extra.CharP


{-| -}
q : Keyboard.Extra.Key
q =
    Keyboard.Extra.CharQ


{-| -}
r : Keyboard.Extra.Key
r =
    Keyboard.Extra.CharR


{-| -}
s : Keyboard.Extra.Key
s =
    Keyboard.Extra.CharS


{-| -}
t : Keyboard.Extra.Key
t =
    Keyboard.Extra.CharT


{-| -}
u : Keyboard.Extra.Key
u =
    Keyboard.Extra.CharU


{-| -}
v : Keyboard.Extra.Key
v =
    Keyboard.Extra.CharV


{-| -}
w : Keyboard.Extra.Key
w =
    Keyboard.Extra.CharW


{-| -}
x : Keyboard.Extra.Key
x =
    Keyboard.Extra.CharX


{-| -}
y : Keyboard.Extra.Key
y =
    Keyboard.Extra.CharY


{-| -}
z : Keyboard.Extra.Key
z =
    Keyboard.Extra.CharZ



-- Number helpers


{-| -}
zero : Keyboard.Extra.Key
zero =
    Keyboard.Extra.Number0


{-| -}
one : Keyboard.Extra.Key
one =
    Keyboard.Extra.Number1


{-| -}
two : Keyboard.Extra.Key
two =
    Keyboard.Extra.Number2


{-| -}
three : Keyboard.Extra.Key
three =
    Keyboard.Extra.Number3


{-| -}
four : Keyboard.Extra.Key
four =
    Keyboard.Extra.Number4


{-| -}
five : Keyboard.Extra.Key
five =
    Keyboard.Extra.Number5


{-| -}
six : Keyboard.Extra.Key
six =
    Keyboard.Extra.Number6


{-| -}
seven : Keyboard.Extra.Key
seven =
    Keyboard.Extra.Number7


{-| -}
eight : Keyboard.Extra.Key
eight =
    Keyboard.Extra.Number8


{-| -}
nine : Keyboard.Extra.Key
nine =
    Keyboard.Extra.Number9



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

        KeyCombo4 key1 key2 key3 key4 msg ->
            [ key1, key2, key3, key4 ]


mapMsgFromCombos : Model msg -> Sub Msg -> Sub msg
mapMsgFromCombos model sub =
    matchesCombo model
        |> Maybe.map getComboMsg
        |> Maybe.map
            (\msg ->
                Sub.batch
                    [ Sub.map (\_ -> msg) sub
                    , Sub.map (\_ -> model.toMsg Reset) sub
                    ]
            )
        |> Maybe.withDefault (Sub.map model.toMsg sub)


getComboMsg : KeyCombo msg -> msg
getComboMsg combo =
    case combo of
        KeyCombo _ msg ->
            msg

        KeyCombo2 _ _ msg ->
            msg

        KeyCombo3 _ _ _ msg ->
            msg

        KeyCombo4 _ _ _ _ msg ->
            msg


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
