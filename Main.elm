import Html exposing (text, Html, div, button, h1)
import Html.Events exposing (onClick)
import Debug exposing (log)
import Random

-- MODEL
type alias Model = Int

init : ( Model, Cmd Msg )
init = ( 1, Cmd.none)


-- UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll -> ( model, Random.generate NewFace (Random.int 1 6))
    NewFace f -> ( f, Cmd.none )

-- MESSAGE
type Msg
  = Roll
  | NewFace Int

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [
      h1 [] [text <| toString model], 
      button [onClick Roll] [text "Roll"]
    ]

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

--MAIN
main : Program Never Model Msg
main =
  Html.program
  { init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
  }
