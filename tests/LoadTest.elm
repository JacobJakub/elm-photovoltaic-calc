module LoadTest exposing (..)

import Load exposing (..)
import Usage exposing (Usage, Appliance)
import Expect exposing (Expectation)
import Test exposing (..)


suite : Test
suite =
    describe "The Load module"
        [ describe "add"
              [ describe "new appliance"
                    [ test "Adds new Usage" <|
                          \_ ->
                            let
                                l : List Usage
                                l = []
                                addUsage =
                                  add (Usage (Appliance "Macbook" 80.0) 45) l
                            in
                                Expect.equal (List.length addUsage) 1
                    ]
              ]
        ]

