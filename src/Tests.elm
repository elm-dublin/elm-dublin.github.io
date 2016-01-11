module Tests where

import ElmTest exposing (..)
import String

passingTest : Test
passingTest =
  test "passing test" (assertEqual 0 0)


failingTest : Test
failingTest =
  test "failing test" (assertEqual 1 0)

someTests : Test
someTests =
  suite "Some Tests"
    [ passingTest
    , failingTest
    ]

tests : Test
tests =
  suite "A Test Suite"
    [ test "Addition" (assertEqual (3 + 7) 10)
    , test "String.left" (assertEqual "a" (String.left 1 "abcdefg"))
    , test "This test should fail" (assert False)
    , someTests
    ]
