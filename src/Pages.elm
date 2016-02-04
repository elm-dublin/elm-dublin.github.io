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
      , { route = Routes.Meetups, label = "Meetups" }
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
    Routes.Home -> viewHome model
    Routes.Meetup meetupId -> viewMeetup meetupId
    Routes.Meetups -> viewMeetups
    Routes.EmptyRoute -> text <| "Not Found"

viewHome : Model -> Html
viewHome model =
  section [ class "jumbotron" ]
    [ Markdown.toHtml ("""
# Elm Dublin User Group

Welcome! We're a group dedicated to [Elm](http://elm-lang.org) programming.
Come along to learn about Elm, chat and hack on Elm projects.
We'll be running social meetups, talks and maybe hack days.

We're an inclusive group, we want folks of all technical levels who are interested in learning or using Elm.
If Elm is your first programming language, good for you, you've made a good choice!
If you've been programming for years and you're dipping your toes into this "functional lark" then you're really going to like Elm.

You can join our [meetup group](http://www.meetup.com/Elm-User-Group-Dublin/) to find out more about the events we run.

We adhere to the conference code of conduct: http://confcodeofconduct.com

If you're curious we have
    """ ++ (toString model.meetupGroup.members) ++ " members.")
    ]

viewMeetups : Html
viewMeetups =
  section []
    [ h1 [] [ text "Meetups Elm Dublin" ]
    , Markdown.toHtml """
We currently run our meetups through Meetup.com, you can join our group [here](http://www.meetup.com/Elm-User-Group-Dublin/).
"""
    ]

viewMeetup : Int -> Html
viewMeetup meetupId =
  section []
    [ h1 [] [ text <| "Meetup " ++ toString meetupId ] ]

clickTo : String -> List Attribute
clickTo path =
  [ href path
  , onWithOptions
      "click"
      { stopPropagation = True, preventDefault = True }
      Json.value
      (\_ -> message TransitRouter.pushPathAddress path)
  ]
