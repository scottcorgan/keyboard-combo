module Keyboard.Key exposing (Key(..), a, b, c, d, decodeKey, e, f, fromCode, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z)

import Json.Decode as Decode exposing (Decoder, field, string)


type Key
    = A
    | B
    | C
    | D
    | E
    | F
    | G
    | H
    | I
    | J
    | K
    | L
    | M
    | N
    | O
    | P
    | Q
    | R
    | S
    | T
    | U
    | V
    | W
    | X
    | Y
    | Z


decodeKey : Decoder Key
decodeKey =
    Decode.map fromCode
        (field "code" string)
        |> Decode.andThen
            (\code ->
                case code of
                    Just key ->
                        Decode.succeed key

                    _ ->
                        Decode.fail "keyboard code not decodeable"
            )


fromCode : String -> Maybe Key
fromCode code =
    case code of
        "KeyA" ->
            Just A

        "KeyB" ->
            Just B

        "KeyC" ->
            Just C

        "KeyD" ->
            Just D

        "KeyE" ->
            Just E

        "KeyF" ->
            Just F

        "KeyG" ->
            Just G

        "KeyH" ->
            Just H

        "KeyI" ->
            Just I

        "KeyJ" ->
            Just J

        "KeyK" ->
            Just K

        "KeyL" ->
            Just L

        "KeyM" ->
            Just M

        "KeyN" ->
            Just N

        "KeyO" ->
            Just O

        "KeyP" ->
            Just P

        "KeyQ" ->
            Just Q

        "KeyR" ->
            Just R

        "KeyS" ->
            Just S

        "KeyT" ->
            Just T

        "KeyU" ->
            Just U

        "KeyV" ->
            Just V

        "KeyW" ->
            Just W

        "KeyX" ->
            Just X

        "KeyY" ->
            Just Y

        "KeyZ" ->
            Just Z

        _ ->
            Nothing



-- Public Functions


a : Key
a =
    A


b : Key
b =
    B


c : Key
c =
    C


d : Key
d =
    D


e : Key
e =
    E


f : Key
f =
    F


g : Key
g =
    G


h : Key
h =
    H


i : Key
i =
    I


j : Key
j =
    J


k : Key
k =
    K


l : Key
l =
    L


m : Key
m =
    M


n : Key
n =
    N


o : Key
o =
    O


p : Key
p =
    P


q : Key
q =
    Q


r : Key
r =
    R


s : Key
s =
    S


t : Key
t =
    T


u : Key
u =
    U


v : Key
v =
    V


w : Key
w =
    W


x : Key
x =
    X


y : Key
y =
    Y


z : Key
z =
    Z
