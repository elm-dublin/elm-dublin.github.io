module Routes where

import Debug
import Effects exposing (Effects)
import RouteParser exposing (..)
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

decode : String -> Route
decode path =
  let
    _ = Debug.log "decode path" path
  in
    RouteParser.match routeParsers path
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
