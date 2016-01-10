module Routes where

import Effects exposing (Effects)
import RouteParser exposing (Matcher, static, dyn1, int)
import TransitRouter

type Route
  = Home
  | Meetup Int
  | Meetups
  | EmptyRoute

routeParsers : List (Matcher Route)
routeParsers =
  [ static Home "/"
  , dyn1 Meetup "/meetups/" int ""
  , static Meetups "/meetups"
  ]

decode : String -> Route
decode path =
  RouteParser.match routeParsers path
    |> Maybe.withDefault EmptyRoute

encode : Route -> String
encode route =
  case route of
    Home -> "/"
    Meetup meetupId -> "/meetup/" ++ toString meetupId
    Meetups -> "/meetups"
    EmptyRoute -> ""

redirect : Route -> Effects ()
redirect route =
  encode route
    |> Signal.send TransitRouter.pushPathAddress
    |> Effects.task
