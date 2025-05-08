module View exposing (..)

import Html.Attributes exposing (..)
import Html exposing (Html, Attribute, div, input, text, li, ul, button, a)
import Html.Events exposing (onClick, onInput)
import Types exposing (..)
import State exposing (getSelectedList)

selectedStyles = [ style "font-weight" "bold"
                 , style "background-color" "blue"
                 , style "color" "white"
                 ]

viewEntry : Item -> Bool -> Html Msg
viewEntry item selected =
    let aItem = a ( [ id (String.fromInt item.itemId), onClick (Select item.itemId) ]
                    ++ if selected then selectedStyles else []
                  )
                [ text item.name ]
    in li [] [ aItem ]

viewEntries : Model -> List (Html Msg)
viewEntries model =
    let id = case model.selectedItem of
                 Just item -> item.itemId
                 Nothing -> -1
    in List.map (\it -> viewEntry it (id == it.itemId)) model.items

textFields : Model -> Html Msg
textFields model =
    let containerStyles = [ style "display" "flex"
                          , style "justify-content" "space-between"
                          , style "align-content" "center"
                          , margin
                          , style "width" "50vw"
                          ]
        margin = style "margin" "5px"
    in div containerStyles
        [ div [] [ input [ margin
                         , placeholder "New list"
                         , onInput ChangeNewListInput
                         , value model.newListInputValue
                         ]
                       []
                 , button [ margin
                          , onClick AddList
                          ]
                       [ text "Add" ]
                 ]
        , div [] [ input [ margin
                         , placeholder "New item"
                         , onInput ChangeNewItemInput
                         , value model.newItemInputValue ]
                       []
                 , button [ margin
                          , onClick AddItem]
                       [ text "Add" ]
                 ]
        ]

frames : List (Html Msg) -> List (Html Msg) -> Html Msg    
frames lists childItems =
    let frameStyles = [ style "width" "50%"
                      , style "height" "100%"
                      , style "border" "1px solid black"
                      ]
        listStyles = [ style "list-style-type" "none"
                     , style "margin" "0px"
                     , style "padding" "30px"
                     ]
    in div [ style "width" "50vw"
           , style "height" "70vh"
           , style "display" "flex"
           ]
        [ div frameStyles [ ul listStyles lists ]
        , div frameStyles [ ul listStyles childItems ]
        ]

view : Model -> Html Msg
view model =
    div
    [ style "display" "flex"
    , style "justify-content" "center"
    , style "align-items" "center"
    , style "width" "100vw"
    , style "height" "100vh"
    , style "flex-direction" "column"
    ]
    [ frames (viewEntries model) (getSelectedList model)
    , textFields model
    ]
