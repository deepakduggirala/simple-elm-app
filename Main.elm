import Html exposing (text, Html, div, input)
import Html.Events exposing (onInput)
import Html.Attributes exposing (placeholder)
import Debug exposing (log)

-- MODEL
type alias Model = String


-- UPDATE
update : Msg -> Model -> Model
update msg model = msg

-- MESSAGE
type alias Msg = String

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [
      input  [placeholder "Text to reverse", onInput identity] [text "+"],
      div [] [text <| String.reverse model]
    ]

--MAIN
main : Program Never String Msg
main =
  Html.beginnerProgram {
    model = "",
    view = view,
    update = update
  }
