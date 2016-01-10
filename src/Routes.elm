module Routes where

import Effects exposing (Effects)
import RouteParser exposing (Matcher, static)
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
