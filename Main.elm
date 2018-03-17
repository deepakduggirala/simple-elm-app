import Html exposing (text, Html, div, button, h2, br, img)
import Html.Events exposing (onClick)
import Debug exposing (log)
import Http
import Json.Decode as Decode
import Html.Attributes exposing (src)

-- MODEL
type alias Model =
  {
    topic: String,
    gifUrl: String
  }

init : String -> ( Model, Cmd Msg )
init topic = ( Model topic "waiting.gif", Cmd.none)


-- UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease -> ( model, getRandomGif model.topic)
    NewGif (Ok newUrl) -> ( Model model.topic newUrl, Cmd.none )
    NewGif (Err _) -> ( model, Cmd.none )

-- MESSAGE
type Msg
  = MorePlease
  | NewGif ( Result Http.Error String )

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [
      h2 [] [text model.topic],
      button [ onClick MorePlease ] [ text "More Please!" ],
      br [] [],
      img [ src model.gifUrl ] []
    ]

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
    Http.send NewGif ( Http.get url decodeGifUrl)
      
decodeGifUrl : Decode.Decoder String
decodeGifUrl =
  Decode.at ["data", "image_url"] Decode.string

--MAIN
main : Program Never Model Msg
main =
  Html.program
  { init = init "cats",
    view = view,
    update = update,
    subscriptions = subscriptions
  }
