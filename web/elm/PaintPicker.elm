module PaintPicker exposing (..)

import Html exposing (Html, ul, li, text)
import Html.Attributes exposing (class)


main : Html String
main =
    view init



-- MODEL
-- Paint is a record containing various attributes
-- assume these Paints work for interior and exterior and are the best brand
-- each paint record is 1 gallon


type alias Paint =
    { color : String
    , sheen : String
    , picked : Bool
    }



-- Model refers to List of Paints


type alias Model =
    List Paint


init : Model
init =
    [ { color = "salmon", sheen = "gloss", picked = False }
    , { color = "tomato", sheen = "flat", picked = False }
    , { color = "darkorange", sheen = "satin", picked = False }
    , { color = "indianred", sheen = "gloss", picked = False }
    , { color = "greenyellow", sheen = "eggshell", picked = False }
    , { color = "mediumspringgreen", sheen = "eggshell", picked = False }
    , { color = "khaki", sheen = "flat", picked = False }
    , { color = "gold", sheen = "flat", picked = False }
    , { color = "rosybrown", sheen = "satin", picked = False }
    , { color = "teal", sheen = "semi-gloss", picked = False }
    , { color = "maroon", sheen = "semi-gloss", picked = False }
    ]



-- VIEW


view : Model -> Html String
view model =
    ul [ class "paints" ] (List.map paintSingle model)


paintSingle : Paint -> Html String
paintSingle paint =
    li [ class "paint available" ] [ text paint.color ]
