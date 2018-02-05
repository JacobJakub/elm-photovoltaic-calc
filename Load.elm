module Load exposing (..)

import Usage exposing (Usage)
import List exposing (isEmpty, filter, map, sum)

-- MODEL

load : List Usage
load =
  []

add : Usage -> List Usage -> List Usage
add usage load =
    if (isEmpty load) || isEmpty (filter (\i -> i.appliance == usage.appliance) load)
      then load ++ [usage]
      else incrementUsage usage load

incrementUsage : Usage -> List Usage -> List Usage
incrementUsage usage load =
    let
        increment u =
            if u.appliance == usage.appliance
                then { u | minutes = u.minutes + usage.minutes }
                else u
    in
        map increment load

getWh : List Usage -> Float
getWh load =
    sum ( map Usage.getWh load )

getAmps : Int -> List Usage -> Float
getAmps voltage load =
    sum ( map ( Usage.getAmps voltage ) load  )
