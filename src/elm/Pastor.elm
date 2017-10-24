port module Pastor exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import HtmlParser exposing (parse)
import HtmlParser.Util exposing (toVirtualDom)
import String exposing (lines)
import List exposing (length)
import Pastor.Ports exposing (..)

main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions }

-- model
type alias Model = { content : String, key : String, preview : String }

-- init
init : ( Model, Cmd msg )
init =
    ( Model "" "" "", Cmd.none )

-- update
type Msg = Content String | Key String | Preview String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Preview preview ->
            ({ model | preview = preview }, Cmd.none)

        Content content ->
            ({ model | content = content }, adoc_in content)

        Key key -> -- the key should be readonly. Also nur einmal schreibbar
            ({ model | key = key }, Cmd.none)


-- view
view : Model -> Html Msg
view model =
    div [ class "base" ]
        [ div [ id "editor-case", class "case"] [ editor model ]
        , div [ id "preview-case", class "case"]  [ render model ] ]


editor : Model -> Html Msg
editor model =
    textarea
        [ id "editor"
        , onInput Content
        , rows ( length (lines model.content))
        , placeholder "put your asciidoc here"]
        [ text model.content ]


render : Model -> Html Msg
render model =
    div [ id "preview" ] ( HtmlParser.parse model.preview  |>  HtmlParser.Util.toVirtualDom )



subscriptions : Model -> Sub Msg
subscriptions model =
    adoc_out Preview
