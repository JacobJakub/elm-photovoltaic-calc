module Battery exposing (Battery, recommend)

import List exposing (head, map, repeat, sortBy, sum)
import Load exposing (getAmps)
import Usage exposing (Usage)


-- MODEL


type alias Battery =
    { name : String
    , maxDischargePercentage : Int
    , ah : Int
    , price : Float
    }


batteries : List Battery
batteries =
    let
        liFePO4 =
            Battery "LiFePO4" 80
    in
    [ liFePO4 40 215.04
    , liFePO4 60 309.12
    , liFePO4 90 483.84
    ]


recommend : Int -> List Usage -> Maybe (List Battery)
recommend volt load =
    let
        getSmallestPack : Float -> Battery -> List Battery
        getSmallestPack amps ({ ah } as battery) =
            (amps / toFloat ah)
                |> ceiling
                |> flip repeat battery
    in
    batteries
        |> map (getSmallestPack <| getAmps volt load)
        |> sortBy packPrice
        |> head


packPrice : List Battery -> Float
packPrice =
    sum << map .price
