module Checks where

import Check exposing (claim, that, is, for, suite, quickCheck)
import Check.Investigator exposing (list, int)

reverse : List a -> List a
reverse list =
  list

claim_reverse_twice_yields_original : Check.Claim
claim_reverse_twice_yields_original =
  claim
    "Reversing a list twice yields the original list"
  `that`
    (\list -> reverse (reverse list))
  `is`
    (identity)
  `for`
    list int


claim_reverse_does_not_modify_length : Check.Claim
claim_reverse_does_not_modify_length =
  claim
    "Reversing a list does not modify its length"
  `that`
    (\list -> List.length (reverse list))
  `is`
    (\list -> List.length list)
  `for`
    list int

suite_reverse : Check.Claim
suite_reverse =
  suite "List Reverse Suite"
    [ claim_reverse_twice_yields_original
    , claim_reverse_does_not_modify_length
    ]

result : Check.Evidence
result = quickCheck suite_reverse
