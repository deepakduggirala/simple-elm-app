import Html exposing (text, Html, div, button, h2, br, img, input)
import Html.Events exposing (onClick, onInput)
import Debug exposing (log)
import Http
import Json.Decode as Decode
import Html.Attributes exposing (src, placeholder)

-- MODEL
type alias Model =
  {
    topic: String,
    gifUrl: String,
    status: String
  }

init : String -> ( Model, Cmd Msg )
init topic = ( Model topic "waiting.gif" "Done", Cmd.none)


-- UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangeTopic topic -> ( Model topic model.gifUrl "Ok", Cmd.none )
    MorePlease -> ( Model model.topic model.gifUrl "Loading", getRandomGif model.topic)
    NewGif (Ok newUrl) -> ( Model model.topic newUrl "Ok", Cmd.none )
    NewGif (Err err) -> ( Model model.topic model.gifUrl (getHttpError err), Cmd.none )

-- MESSAGE
type Msg
  = MorePlease
  | NewGif ( Result Http.Error String )
  | ChangeTopic String

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [
      input [ onInput ChangeTopic, placeholder model.topic] [],
      button [ onClick MorePlease ] [ text "More Please!" ],
      br [] [],
      h2 [] [text model.gifUrl],
      h2 [] [text model.status],
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

getHttpError : Http.Error -> String
getHttpError e =
  case e of
    Http.BadUrl url -> "Bad Url : " ++ url
    Http.Timeout -> "Request timedout"
    Http.NetworkError -> "Network Error"
    Http.BadStatus response -> "Bad Status : " ++ toString response.status
    Http.BadPayload status response -> "Bad Payload : " ++ status

--MAIN
main : Program Never Model Msg
main =
  Html.program
  { init = init "cats",
    view = view,
    update = update,
    subscriptions = subscriptions
  }
