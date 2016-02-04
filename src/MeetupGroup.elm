module MeetupGroup where

import Effects exposing (Effects)
import Http
import Json.Decode as Json exposing (int, string, (:=))
import Task

type alias Model =
  { id: Int
  , members: Int
  , link: String
  }

type Action =
  GotGroup (Maybe Model)

init : (Model, Effects Action)
init =
  let
    model =
      { id = 0
      , members = 0
      , link = ""
      }
  in
    ( model
    , getGroup
    )

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    GotGroup maybeModel ->
      ( Maybe.withDefault model maybeModel
      , Effects.none
      )

-- These are specifically signed requests, it's hard to rebuild them exactly to match so easier to
-- use verbatim.
getGroupUrl : String
getGroupUrl = "https://api.meetup.com/Elm-User-Group-Dublin?photo-host=public&sig_id=1541118&fields=next_event%2Clast_event%2Cevent_sample&sig=14600b486bba65456dadf0d7773b18df14642edd"

getGroup : Effects Action
getGroup =
  Http.get decodeGetGroupJson getGroupUrl
    |> Task.toMaybe
    |> Task.map GotGroup
    |> Effects.task

decodeGetGroupJson : Json.Decoder Model
decodeGetGroupJson =
  Json.object3 Model
    ("id" := int)
    ("members" := int)
    ("link" := string)
