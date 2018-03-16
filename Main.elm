import Html exposing (text, Html, div, input)
import Html.Events exposing (onInput)
import Html.Attributes exposing (placeholder, type_)
import Debug exposing (log)

-- MODEL
type alias Model =
  {
    name: String,
    password: String,
    passwordAgain: String
  }

model : Model
model = Model "" "" ""


-- UPDATE
update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name -> { model | name = name }
    Password password -> { model | password = password }
    PasswordAgain passwordAgain -> { model | passwordAgain = passwordAgain }

-- MESSAGE
type Msg =
  Name String
  | Password String
  | PasswordAgain String

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [
      input  [type_ "text", placeholder "Name", onInput Name] [],
      input  [type_ "password", placeholder "Password", onInput Password] [],
      input  [type_ "password", placeholder "Re-enter password", onInput PasswordAgain] [],
      viewValidation model
    ]

viewValidation : Model -> Html Msg
viewValidation model =
  text <| if model.password == model.passwordAgain
    then "OK"
    else "Passwords do not match"

--MAIN
main : Program Never Model Msg
main =
  Html.beginnerProgram {
    model = model,
    view = view,
    update = update
  }
