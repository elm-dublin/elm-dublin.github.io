module Pages where

import Html exposing (..)
import Signal exposing (Address)
import Markdown
import TransitRouter

import ElmDublin exposing (Action, Model)
import Routes

view : Address Action -> Model -> Html
view action model =
  div []
    [ viewHome
    , content action model
    , text <| toString model
    ]

content : Address Action -> Model -> Html
content action model =
  case (TransitRouter.getRoute model) of
    Routes.Home -> viewHome
    Routes.About -> viewAbout
    Routes.EmptyRoute -> text <| "Not Found"

viewHome : Html
viewHome =
  Markdown.toHtml """
  # Elm Dublin User Group

  Welcome!

  """

viewAbout : Html
viewAbout =
  Markdown.toHtml """
  # About Elm Dublin

  We like Elm
  """
