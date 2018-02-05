module Battery exposing (Battery, recommend)

import Usage exposing (Usage)
import Load exposing (getAmps)
import List exposing (sum, map, repeat, sortBy, head)
-- MODEL

type alias Battery =
    { name : String
    , maxDischargePercentage : Int
    , ah : Int
    , price : Float
    }

liFePO4 = Battery "LiFePO4" 80

batteries : List Battery
batteries =
    [ liFePO4 40 215.04
    , liFePO4 60 309.12
    , liFePO4 90 483.84
    ]

recommend : Int -> List Usage -> Maybe ( List Battery )
recommend volt load =
    let
      getSmallestPack : Float -> Battery -> List Battery
      getSmallestPack amps battery =
          repeat ( ceiling ( amps / toFloat battery.ah ) ) battery
    in
        head ( sortBy packPrice ( map ( getSmallestPack ( getAmps volt load ) ) batteries ) )

packPrice : List Battery -> Float
packPrice batteryPack =
    sum ( map .price batteryPack )
