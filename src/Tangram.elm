module Tangram where

{-| A rendering of the Elm Tangram logo

Originally from https://github.com/robertjlooby/tangram , code changed to bring up to date with
latest Elm.

-}

import Color exposing (Color, rgb)
import Graphics.Collage exposing (Form, collage, scale, filled, polygon)
import Graphics.Element exposing (Element)
import Window

--colors
elmGreen : Color
elmGreen = rgb 141 215 55

elmTurquoise : Color
elmTurquoise = rgb 96 181 204

elmOrange : Color
elmOrange = rgb 239 165 0

elmGray : Color
elmGray = rgb 90 99 120

--shapes
scalingFactor : (Int, Int) -> Float
scalingFactor (width, height) = (min (toFloat width) (toFloat height)) / 3

filledForm : Float -> Color -> List (Float, Float) -> Form
filledForm scaleFactor color points = scale scaleFactor (filled color (polygon points))

logo : Float -> List Form
logo scaleFactor =
  [ (filledForm scaleFactor elmTurquoise [(0, 0),  (-1, -1),   (1, -1)                 ])
  , (filledForm scaleFactor elmGray      [(0, 0),  (-1, -1),   (-1, 1)                 ])
  , (filledForm scaleFactor elmTurquoise [(1, 1),  (0, 1),     (1, 0)                  ])
  , (filledForm scaleFactor elmOrange    [(1, -1), (1, 0),     (0.5, -0.5)             ])
  , (filledForm scaleFactor elmOrange    [(0, 0),  (0.5, 0.5), (-0.5, 0.5)             ])
  , (filledForm scaleFactor elmGreen     [(0, 0),  (0.5, 0.5), (1, 0),      (0.5, -0.5)])
  , (filledForm scaleFactor elmGreen     [(0, 1),  (-1, 1),    (-0.5, 0.5), (0.5, 0.5) ])
  ]

--functions
displayCentered : (Int, Int) -> List Form -> Element
displayCentered (width, height) forms = collage width height forms

updatedScalingFactor : Signal Float
updatedScalingFactor = (Signal.map scalingFactor Window.dimensions)

scaledLogo : Signal (List Form)
scaledLogo = Signal.map logo updatedScalingFactor

main : Signal Element
main = Signal.map2 displayCentered Window.dimensions scaledLogo
