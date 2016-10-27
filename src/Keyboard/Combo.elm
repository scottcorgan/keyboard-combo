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

{-| Provides helpers to call messages on the give keyboard combinations

@docs KeyCombo, Model, Msg, update, init, subscriptions

## Combo Helpers

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
    | KeyCombo4 Keyboard.Extra.Key Keyboard.Extra.Key Keyboard.Extra.Key Keyboard.Extra.Key msg



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


{-| -}
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


{-| Letter helper for 'a'
-}
a : Keyboard.Extra.Key
a =
    Keyboard.Extra.CharA


{-| Letter helper for 'b'
-}
b : Keyboard.Extra.Key
b =
    Keyboard.Extra.CharB


{-| Letter helper for 'c'
-}
c : Keyboard.Extra.Key
c =
    Keyboard.Extra.CharC


{-| Letter helper for 'd'
-}
d : Keyboard.Extra.Key
d =
    Keyboard.Extra.CharD


{-| Letter helper for 'e'
-}
e : Keyboard.Extra.Key
e =
    Keyboard.Extra.CharE


{-| Letter helper for 'f'
-}
f : Keyboard.Extra.Key
f =
    Keyboard.Extra.CharF


{-| Letter helper for 'g'
-}
g : Keyboard.Extra.Key
g =
    Keyboard.Extra.CharG


{-| Letter helper for 'h'
-}
h : Keyboard.Extra.Key
h =
    Keyboard.Extra.CharH


{-| Letter helper for 'i'
-}
i : Keyboard.Extra.Key
i =
    Keyboard.Extra.CharI


{-| Letter helper for 'j'
-}
j : Keyboard.Extra.Key
j =
    Keyboard.Extra.CharJ


{-| Letter helper for 'k'
-}
k : Keyboard.Extra.Key
k =
    Keyboard.Extra.CharK


{-| Letter helper for 'l'
-}
l : Keyboard.Extra.Key
l =
    Keyboard.Extra.CharL


{-| Letter helper for 'm'
-}
m : Keyboard.Extra.Key
m =
    Keyboard.Extra.CharM


{-| Letter helper for 'n'
-}
n : Keyboard.Extra.Key
n =
    Keyboard.Extra.CharN


{-| Letter helper for 'o'
-}
o : Keyboard.Extra.Key
o =
    Keyboard.Extra.CharO


{-| Letter helper for 'p'
-}
p : Keyboard.Extra.Key
p =
    Keyboard.Extra.CharP


{-| Letter helper for 'q'
-}
q : Keyboard.Extra.Key
q =
    Keyboard.Extra.CharQ


{-| Letter helper for 'r'
-}
r : Keyboard.Extra.Key
r =
    Keyboard.Extra.CharR


{-| Letter helper for 's'
-}
s : Keyboard.Extra.Key
s =
    Keyboard.Extra.CharS


{-| Letter helper for 't'
-}
t : Keyboard.Extra.Key
t =
    Keyboard.Extra.CharT


{-| Letter helper for 'u'
-}
u : Keyboard.Extra.Key
u =
    Keyboard.Extra.CharU


{-| Letter helper for 'v'
-}
v : Keyboard.Extra.Key
v =
    Keyboard.Extra.CharV


{-| Letter helper for 'w'
-}
w : Keyboard.Extra.Key
w =
    Keyboard.Extra.CharW


{-| Letter helper for 'x'
-}
x : Keyboard.Extra.Key
x =
    Keyboard.Extra.CharX


{-| Letter helper for 'y'
-}
y : Keyboard.Extra.Key
y =
    Keyboard.Extra.CharY


{-| Letter helper for 'z'
-}
z : Keyboard.Extra.Key
z =
    Keyboard.Extra.CharZ



-- Number helpers


{-| Number helper for '0'
-}
zero : Keyboard.Extra.Key
zero =
    Keyboard.Extra.Number0


{-| Number helper for '1'
-}
one : Keyboard.Extra.Key
one =
    Keyboard.Extra.Number1


{-| Number helper for '2'
-}
two : Keyboard.Extra.Key
two =
    Keyboard.Extra.Number2


{-| Number helper for '3'
-}
three : Keyboard.Extra.Key
three =
    Keyboard.Extra.Number3


{-| Number helper for '4'
-}
four : Keyboard.Extra.Key
four =
    Keyboard.Extra.Number4


{-| Number helper for '5'
-}
five : Keyboard.Extra.Key
five =
    Keyboard.Extra.Number5


{-| Number helper for '6'
-}
six : Keyboard.Extra.Key
six =
    Keyboard.Extra.Number6


{-| Number helper for '7'
-}
seven : Keyboard.Extra.Key
seven =
    Keyboard.Extra.Number7


{-| Number helper for '8'
-}
eight : Keyboard.Extra.Key
eight =
    Keyboard.Extra.Number8


{-| Number helper for '9'
-}
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
