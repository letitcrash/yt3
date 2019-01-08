port module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as D
import Json.Encode as E


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Meta =
    { title : Maybe String
    , thumbnail_url : Maybe String
    }


type alias File =
    { file : String
    , id : Int
    }


type alias Model =
    { url : String
    , mediaType : String
    , meta : Meta
    , file : File
    }


init : String -> ( Model, Cmd Msg )
init uri =
    ( { url = uri
      , mediaType = "audio/mpeg"
      , meta =
            { title = Nothing
            , thumbnail_url = Nothing
            }
      , file =
            { file = ""
            , id = 0
            }
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Url String
    | SendUrl
    | MetaMsg E.Value
    | FileMsg E.Value


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Url content ->
            ( { model | url = content }, Cmd.none )

        SendUrl ->
            ( { model | url = "" }
            , url (E.object [ ( "url", E.string model.url ) ])
            )

        MetaMsg value ->
            let
                result =
                    D.decodeValue decodeMeta value
            in
            case result of
                Ok metaInfo ->
                    ( { model | meta = metaInfo }, Cmd.none )

                _ ->
                    Debug.todo "ERROR DECODING"

        FileMsg value ->
            let
                result =
                    D.decodeValue decodeFile value
            in
            case result of
                Ok fileInfo ->
                    ( { model | file = fileInfo }, Cmd.none )

                _ ->
                    ( model, Cmd.none )


port url : E.Value -> Cmd msg


port meta : (E.Value -> msg) -> Sub msg


port file : (E.Value -> msg) -> Sub msg


decodeMeta : D.Decoder Meta
decodeMeta =
    D.map2 Meta
        (D.maybe (D.field "title" D.string))
        (D.maybe (D.field "thumbnail_url" D.string))


decodeFile : D.Decoder File
decodeFile =
    D.map2 File
        (D.field "file" D.string)
        (D.field "id" D.int)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ meta MetaMsg
        , file FileMsg
        ]



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "player" ]
        [ div [ class "form-wrapper" ]
            [ Html.form
                [ onSubmit SendUrl
                , class ""
                ]
                [ input
                    [ onInput Url
                    , value model.url
                    , class ""
                    , type_ "text"
                    , placeholder "Youtube URL"
                    ]
                    []
                , button
                    [ class ""
                    , type_ "submit"
                    ]
                    [ text "play" ]
                ]
            ]
        , div [ class "meta" ]
            [ div
                [ class "meta-title" ]
                [ viewMetaTitle model.meta.title ]
            , div
                [ class "meta-thumbnail" ]
                [ viewMetaImage model.meta.thumbnail_url ]
            ]
        , div [ class "audio-player" ]
            [ audio
                [ src model.file.file
                , id "audio-player"
                , controls True
                ]
                []
            ]
        ]


viewMetaTitle : Maybe String -> Html Msg
viewMetaTitle metaTitle =
    case metaTitle of
        Just title ->
            p [ class "title" ] [ text ("Playing " ++ title) ]

        Nothing ->
            p [ class "title" ] [ text "Add Youtube URL" ]


viewMetaImage : Maybe String -> Html Msg
viewMetaImage metaImage =
    case metaImage of
        Just imageUrl ->
            img [ src imageUrl ] []

        Nothing ->
            Html.text ""
