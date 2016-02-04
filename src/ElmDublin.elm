module ElmDublin where

import Effects exposing (Effects)
import Signal
import TransitRouter exposing (WithRoute)
import Routes exposing (Route)

import MeetupGroup

type alias Model =
  WithRoute Route
  { meetupGroup: MeetupGroup.Model
  }

initialModel : (Model, Effects Action)
initialModel =
  let
    transitRouter = TransitRouter.empty Routes.EmptyRoute
    (group, fx) = MeetupGroup.init
  in
    ( { meetupGroup = group
      , transitRouter = transitRouter
      }
    , Effects.map MeetupGroup fx
    )


type Action
  = NoOp
  | RouterAction (TransitRouter.Action Route)
  | MeetupGroup MeetupGroup.Action


actions : Signal Action
actions =
  Signal.map RouterAction TransitRouter.actions


routerConfig : TransitRouter.Config Route Action Model
routerConfig =
  { mountRoute = mountRoute
  , getDurations = \_ _ _ -> (50, 200)
  , actionWrapper = RouterAction
  , routeDecoder = Routes.decode
  }

mountRoute : Route -> Route -> Model -> (Model, Effects Action)
mountRoute previousRoute route model =
  case route of
    Routes.Home ->
      (model, Effects.none)
    Routes.Meetup meetupId ->
      (model, Effects.none)
    Routes.Meetups ->
      (model, Effects.none)
    Routes.EmptyRoute ->
      (model, Effects.none)

init : String -> (Model, Effects Action)
init path =
  let
    (model, fx) = initialModel
    (m, transitFx) = TransitRouter.init routerConfig path model
  in
    ( m
    , Effects.batch [transitFx, fx]
    )


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp ->
      (model, Effects.none)

    MeetupGroup act ->
      let
        (group, fx) = MeetupGroup.update act model.meetupGroup
      in
        ( { model | meetupGroup = group }
        , Effects.map MeetupGroup fx)

    RouterAction routeAction ->
      TransitRouter.update routerConfig routeAction model
