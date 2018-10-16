module Calculator exposing (..)

import Usage exposing (Usage, Appliance)
import Load exposing (getWh, getAmps, add)
import Html exposing (Html, text, div, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import List exposing (map)
import Round

-- MODEL

type alias Model =
    { fullLoad : List Usage
    }

model : Model
model =
  { fullLoad = [(Usage (Appliance "Kettle" 80.0) 45), (Usage (Appliance "Macbook" 80.0) 75)]
  }

formUsage : Usage
Usage =
    Usage ( Appliance "" 0) 0


-- UPDATE

type Msg =
    AddLoad
  | RemoveLoad Usage

update : Msg -> Model -> Model
update msg model =
    case msg of
        AddLoad ->
            let
                data =
                    (Usage (Appliance "Vybrator" 80.0) 45)
            in
                { model | fullLoad = add data model.fullLoad }
        RemoveLoad load ->
            { model | fullLoad = List.filter (\ l -> (l /= load)) model.fullLoad }


-- VIEW

sidebarView : List Usage -> Html Msg
sidebarView model =
    div [ class "sidebar" ]
      [ text ( "Total Wh: " ++ toString ( getWh model ) )
      , text ( "Total Amps (12v): " ++ Round.round 2 ( getAmps 12 model ) )
      , text ( "Total Amps (220v): " ++ Round.round 2 ( getAmps 220 model ) )
      ]

loadView : Usage -> Html Msg
loadView usage =
    div [ class "load" ]
        [ text usage.appliance.name
        , text ( " Minutes: " ++ toString usage.minutes ++ " Watt: " ++ toString usage.appliance.watt )
        , button [ onClick ( RemoveLoad usage ) ] [ text "-"]
    ]

fullLoadView : Model -> Html Msg
fullLoadView model =
    div [ class "full-load-list"]
        [ div []
            ( map loadView model.fullLoad )
        , sidebarView model.fullLoad
        , div [ class "actions" ] [ button [ onClick AddLoad ] [ text "+"] ]
        ]

main =
  Html.beginnerProgram
    { model = model
    , view = fullLoadView
    , update = update
    }

