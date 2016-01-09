module Routes where

import Effects exposing (Effects)
import RouteParser exposing (..)
import String
import TransitRouter

type Route
  = Home
  | About
  | EmptyRoute

routeParsers : List (Matcher Route)
routeParsers =
  [ static Home "/"
  , static About "/about"
  ]

decode : String -> String -> Route
decode prefix path =
  let
    fixedPath = "/" ++ String.dropLeft (String.length prefix) path
  in
    RouteParser.match routeParsers fixedPath
      |> Maybe.withDefault EmptyRoute

encode : Route -> String
encode route =
  case route of
    Home -> "/"
    About -> "/about"
    EmptyRoute -> ""

redirect : Route -> Effects ()
redirect route =
  encode route
    |> Signal.send TransitRouter.pushPathAddress
    |> Effects.task
