module Usage exposing (Usage, Appliance, getWh, getAmps)

-- MODEL

type alias Appliance =
    { name : String
    , watt : Float
    }

type alias Usage =
    { appliance : Appliance
    , minutes : Int
    }

getWh : Usage -> Float
getWh usage =
    usage.appliance.watt * ( toFloat usage.minutes / 60 )

getAmps : Int -> Usage -> Float
getAmps voltage usage =
    getWh usage / toFloat voltage
