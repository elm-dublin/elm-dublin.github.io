module Pages where

import Bootstrap.Html exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Signal exposing (..)
import TransitRouter
import TransitStyle

import ElmDublin exposing (Action, Model)
import Routes

view : Address Action -> Model -> Html
view action model =
  div [ class "container" ]
    [ header action model
    , article
        [ style (TransitStyle.fadeSlideLeft 100 (TransitRouter.getTransition model)) ]
        [ content action model ]
    ]

header : Address Action -> Model -> Html
header action model =
  let
    routes =
      [ { route = Routes.Home, label = "Home" }
      , { route = Routes.About, label = "About" }
      ]
    activeRoute route = if TransitRouter.getRoute model == route then [ class "active" ] else []
  in
    navbar' "navbar-default"
      [ containerFluid_
          [ navbarHeader_
              (List.map (\_ -> span [ class "icon-bar" ] []) routes)
          ]
        , div [ class "collapse navbar-collapse" ]
            [ ul [ class "nav navbar-nav"]
                (List.map (\r -> li (activeRoute r.route) [ a (clickTo <| Routes.encode r.route) [ text r.label ] ]) routes)
            ]
      ]

content : Address Action -> Model -> Html
content action model =
  case (TransitRouter.getRoute model) of
    Routes.Home -> viewHome
    Routes.About -> viewAbout
    Routes.EmptyRoute -> text <| "Not Found"

viewHome : Html
viewHome =
  section []
    [ h1 [] [ text "Elm Dublin User Group" ]
    , p [] [ text "Welcome!"]
    ]

viewAbout : Html
viewAbout =
  section []
    [ h1 [] [ text "About Elm Dublin" ]
    , p [] [ text "We like Elm" ]
    ]

clickTo : String -> List Attribute
clickTo path =
  [ href path
  , onWithOptions
      "click"
      { stopPropagation = True, preventDefault = True }
      Json.value
      (\_ -> message TransitRouter.pushPathAddress path)
  ]
