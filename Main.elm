module Main where

import Effects exposing (Never)
import Html
import Signal
import StartApp
import Task

import ElmDublin exposing (init, update, actions)
import Pages exposing (view)

port initialPath : String

app : StartApp.App ElmDublin.Model
app =
  StartApp.start
    { init = init initialPath
    , update = update
    , view = view
    , inputs = [ actions ]
    }

main : Signal Html.Html
main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
