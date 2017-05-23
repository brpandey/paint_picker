module PaintPicker exposing (..)

import Html exposing (Html, ul, li, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Json.Decode as Decode exposing (Decoder, field)
import Http


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }



-- MODEL
-- Paint is a record containing various attributes
-- assume these Paints work for interior and exterior and are the best brand
-- each paint record is 1 gallon


type alias Paint =
    { cart : Int
    , color : String
    , sheen : String
    , picked : Bool
    }



-- Model refers to List of Paints


type alias Model =
    List Paint


init : ( Model, Cmd Msg )
init =
    -- Fire off a Cmd to the Elm Runtime,
    -- getPaints from the Paints HTTP API
    ( [], getPaints )



-- UPDATE (let's add some interactivity so we can update our model!)


type Msg
    = Pick Paint
    | NewPaints (Result Http.Error (List Paint))


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Pick pickedPaint ->
            -- if we pick it once, its picked, twice, not picked
            let
                refreshPaint paint =
                    if paint.cart == pickedPaint.cart then
                        { paint | picked = not paint.picked }
                    else
                        paint
            in
                -- apply to each model list paint
                ( List.map refreshPaint model, Cmd.none )

        NewPaints (Ok seats) ->
            ( seats, Cmd.none )

        NewPaints (Err error) ->
            let
                _ =
                    Debug.log "OOps!" error
            in
                ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    ul [ class "paints" ] (List.map paintSingle model)


paintSingle : Paint -> Html Msg
paintSingle paint =
    let
        pickedClass =
            if paint.picked then
                paint.color
            else
                "available"
    in
        li [ class ("paint " ++ pickedClass), onClick (Pick paint) ]
            [ text (toString paint.cart ++ " " ++ paint.color) ]



-- CMD


paintsApiUrl : String
paintsApiUrl =
    "http://localhost:4000/api/paints"


getPaints : Cmd Msg
getPaints =
    -- Wraps the Http request in a Command Msg
    -- Cmd will be performed by Elm runtime (will go back to update eventually)
    -- Note unlike Elixir, Elm pipes into the last-rightmost arg == partial functions
    -- The Msg will be a list of already validated Paint records
    (Decode.at [ "data" ] (Decode.list paintDecoder))
        |> Http.get paintsApiUrl
        |> Http.send NewPaints



-- Validates and parses Json into Paint record


paintDecoder : Decoder Paint
paintDecoder =
    Decode.map4 Paint
        (field "cart" Decode.int)
        (field "color" Decode.string)
        (field "sheen" Decode.string)
        (field "picked" Decode.bool)
