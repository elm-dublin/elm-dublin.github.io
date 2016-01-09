module ElmDublin where

import Effects exposing (Effects)
import Signal
import TransitRouter exposing (WithRoute)
import Routes exposing (Route)

type alias Model = WithRoute Route
  { prefix: String
  }

initialModel : String -> Model
initialModel prefix =
  { transitRouter = TransitRouter.empty Routes.EmptyRoute
  , prefix = prefix
  }



type Action
  = NoOp
  | RouterAction (TransitRouter.Action Route)


actions : Signal Action
actions =
  Signal.map RouterAction TransitRouter.actions


routerConfig : String -> TransitRouter.Config Route Action Model
routerConfig prefix =
  { mountRoute = mountRoute
  , getDurations = \_ _ _ -> (50, 200)
  , actionWrapper = RouterAction
  , routeDecoder = Routes.decode prefix
  }

mountRoute : Route -> Route -> Model -> (Model, Effects Action)
mountRoute previousRoute route model =
  case route of
    Routes.Home ->
      (model, Effects.none)
    Routes.About ->
      (model, Effects.none)
    Routes.EmptyRoute ->
      (model, Effects.none)

init : String -> (Model, Effects Action)
init path =
  TransitRouter.init (routerConfig path) path (initialModel path)

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp ->
      (model, Effects.none)

    RouterAction routeAction ->
      TransitRouter.update (routerConfig model.prefix) routeAction model
