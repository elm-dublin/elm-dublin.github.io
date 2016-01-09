module Pages where

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
  div []
    [ header action model
    , article
        [ style (TransitStyle.fadeSlideLeft 100 (TransitRouter.getTransition model)) ]
        [ content action model ]
    ]

header : Address Action -> Model -> Html
header action model =
  Html.header []
    [ nav []
      [ ul []
        [ li [] [ a (clickTo <| Routes.encode Routes.Home) [ text "Home" ] ]
        , li [] [ a (clickTo <| Routes.encode Routes.About) [ text "About" ] ]
        ]
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
