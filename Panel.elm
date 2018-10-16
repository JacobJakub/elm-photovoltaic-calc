module Panel exposing (Panel)

-- MODEL

type alias Panel =
    { name : String
    , technology : Technology
    , efficiency : Float
    , wp : Int
    , price : Float
    }

type Technology
    = Mono
    | Poly

panels =
    [ Panel "GWL/Power Solar panel GWL/Sunny Flexible Mono 60 Wp (MPPT 18V)" Mono 19.2 60 100.46
    , Panel "GWL/Power Solar panel GWL/Sunny Flexible Mono 100 Wp (MPPT 18V)" Mono 21 100 150.28
    , Panel "GWL/Power Solar panel GWL/Sunny Mono 280Wp, 60 cells" Mono 17.1 280 157.95
    , Panel "GWL/Power Solar panel GWL/Sunny Mono 300Wp 60 cells (MPPT 32V) Full black" Mono 18.35 300 186.56
    ]
