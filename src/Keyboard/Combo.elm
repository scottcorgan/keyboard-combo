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
        )

{-| Provides helpers to call messages on the give keyboard combinations

@docs KeyCombo, Model, Msg, update, init, subscriptions

## Combo Helpers

@docs combo1, combo2, combo3, combo4

## Modifiers

@docs super, command, shift, control, alt, option


## Letters

@docs a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
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
    Keyboard.Extra.CharA


{-| Letter helper for 'c'
-}
c : Keyboard.Extra.Key
c =
    Keyboard.Extra.CharA


{-| Letter helper for 'd'
-}
d : Keyboard.Extra.Key
d =
    Keyboard.Extra.CharA


{-| Letter helper for 'e'
-}
e : Keyboard.Extra.Key
e =
    Keyboard.Extra.CharA


{-| Letter helper for 'f'
-}
f : Keyboard.Extra.Key
f =
    Keyboard.Extra.CharA


{-| Letter helper for 'g'
-}
g : Keyboard.Extra.Key
g =
    Keyboard.Extra.CharA


{-| Letter helper for 'h'
-}
h : Keyboard.Extra.Key
h =
    Keyboard.Extra.CharA


{-| Letter helper for 'i'
-}
i : Keyboard.Extra.Key
i =
    Keyboard.Extra.CharA


{-| Letter helper for 'j'
-}
j : Keyboard.Extra.Key
j =
    Keyboard.Extra.CharA


{-| Letter helper for 'k'
-}
k : Keyboard.Extra.Key
k =
    Keyboard.Extra.CharA


{-| Letter helper for 'l'
-}
l : Keyboard.Extra.Key
l =
    Keyboard.Extra.CharA


{-| Letter helper for 'm'
-}
m : Keyboard.Extra.Key
m =
    Keyboard.Extra.CharA


{-| Letter helper for 'n'
-}
n : Keyboard.Extra.Key
n =
    Keyboard.Extra.CharA


{-| Letter helper for 'o'
-}
o : Keyboard.Extra.Key
o =
    Keyboard.Extra.CharA


{-| Letter helper for 'p'
-}
p : Keyboard.Extra.Key
p =
    Keyboard.Extra.CharA


{-| Letter helper for 'q'
-}
q : Keyboard.Extra.Key
q =
    Keyboard.Extra.CharA


{-| Letter helper for 'r'
-}
r : Keyboard.Extra.Key
r =
    Keyboard.Extra.CharA


{-| Letter helper for 's'
-}
s : Keyboard.Extra.Key
s =
    Keyboard.Extra.CharA


{-| Letter helper for 't'
-}
t : Keyboard.Extra.Key
t =
    Keyboard.Extra.CharA


{-| Letter helper for 'u'
-}
u : Keyboard.Extra.Key
u =
    Keyboard.Extra.CharA


{-| Letter helper for 'v'
-}
v : Keyboard.Extra.Key
v =
    Keyboard.Extra.CharA


{-| Letter helper for 'w'
-}
w : Keyboard.Extra.Key
w =
    Keyboard.Extra.CharA


{-| Letter helper for 'x'
-}
x : Keyboard.Extra.Key
x =
    Keyboard.Extra.CharA


{-| Letter helper for 'y'
-}
y : Keyboard.Extra.Key
y =
    Keyboard.Extra.CharA


{-| Letter helper for 'z'
-}
z : Keyboard.Extra.Key
z =
    Keyboard.Extra.CharA



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
        |> Maybe.map
            (\combo ->
                case combo of
                    KeyCombo _ msg ->
                        msg

                    KeyCombo2 _ _ msg ->
                        msg

                    KeyCombo3 _ _ _ msg ->
                        msg

                    KeyCombo4 _ _ _ _ msg ->
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
