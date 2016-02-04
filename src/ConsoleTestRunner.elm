import Task

import Console
import ElmTest exposing (consoleRunner)

import Tests

port runner : Signal (Task.Task x ())
port runner =
    Console.run (consoleRunner Tests.tests)
