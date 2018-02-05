module LoadTest exposing (..)

import Load exposing (..)
import Usage exposing (Usage, Appliance)
import Expect exposing (Expectation)
import Test exposing (..)


suite : Test
suite =
    describe "The Load module"
        [ describe "add"
              [ describe "Multiple appliances"
                    [ test "Adds new Usage" <|
                          \_ ->
                            let
                                l : List Usage
                                l = []
                                addUsage =
                                  l |> add (Usage (Appliance "Macbook" 80.0) 45) |> add (Usage (Appliance "Kettle" 80.0) 45)
                            in
                                Expect.equal (List.length addUsage) 2
                    ]
              , describe "Single appliace"
                    [ test "Increases existing usage" <|
                          \_ ->
                            let
                                l : List Usage
                                l = []
                                addUsage =
                                  l |> add (Usage (Appliance "Macbook" 80.0) 45) |> add (Usage (Appliance "Macbook" 80.0) 50)
                            in
                                Expect.equal addUsage [Usage (Appliance "Macbook" 80.0) 95]
                    ]
              ]
        , describe "getApms"
            [ test "should calculate amps correctly" <|
                  \_ ->
                    let
                      l : List Usage
                      l = []
                      addUsage =
                        add (Usage (Appliance "Macbook" 180.0) 60) l
                    in
                        Expect.equal ( getAmps 12 addUsage ) 15
            ]
        ]
