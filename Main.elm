import Html exposing (text, button, Html, div)
import Html.Events exposing (onClick)
import Debug exposing (log)

-- MODEL
type alias Model = Int


-- UPDATE
update : Msg -> Model -> Model
update msg model =
  case msg of
    Incriment -> model + 1
    Decrement -> model - 1

type Msg = Incriment | Decrement

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [
      button [onClick Incriment] [text "+"],
      button [onClick Decrement] [text "-"],
      text <| toString model
    ]

--MAIN
main : Program Never Int Msg
main =
  Html.beginnerProgram {
    model = 0,
    view = view,
    update = update
  }
