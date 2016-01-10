module Pages where

import Bootstrap.Html exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Markdown
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
  section [ class "jumbotron" ]
    [ Markdown.toHtml """
# Elm Dublin User Group

Welcome! We're a group dedicated to Elm programming.
Come along to learn about Elm, chat and hack on Elm projects.
We'll be running social meetups, talks and maybe hack days.

We're an inclusive group, we want folks of all technical levels who are interested in learning or using Elm.
If Elm is your first programming language, good for you, you've made a good choice!
If you've been programming for years and you're dipping your toes into this "functional lark" then you're really going to like Elm.

We adhere to the conference code of conduct: http://confcodeofconduct.com
    """
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
