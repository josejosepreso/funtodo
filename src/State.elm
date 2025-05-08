module State exposing (..)

import Types exposing (..)
import Html exposing (Html, li, text)

init : Model
init =
    { items = []
    , newListInputValue = ""
    , newItemInputValue = ""
    , selectedItem = Nothing
    }

update : Msg -> Model -> Model
update msg model =
    case msg of
        Select id -> selectList id model
        AddList -> addNewList model
        AddItem -> addNewChild model
        ChangeNewListInput value -> { model | newListInputValue = value }
        ChangeNewItemInput value -> { model | newItemInputValue = value }

addToItem : List Item -> Int -> String -> List Item
addToItem list id content =
    case list of
        [] -> []
        item :: items -> if item.itemId == id then
                             { item | childItems = item.childItems ++ [content] } :: items
                         else 
                             item :: (addToItem items id content)
                                    
addNewChild : Model -> Model
addNewChild model =
    if model.newItemInputValue == "" then model
    else case model.selectedItem of
             Nothing -> model
             Just item -> let content = model.newItemInputValue
                              selected = { item | childItems = item.childItems ++ [content] }
                              updatedItems = addToItem model.items item.itemId content
                          in { model | selectedItem = Just selected
                             , items = updatedItems
                             , newItemInputValue = ""
                             }
                                    
getItemById : List Item -> Int -> Maybe Item
getItemById list id =
    case list of
        [] -> Nothing
        item :: items -> if item.itemId == id then Just item
                         else getItemById items id
                                    
getSelectedList : Model -> List (Html Msg)
getSelectedList model =
    case model.selectedItem of
        Just item -> List.map (\s -> li [] [ text s ]) item.childItems
        Nothing -> []
                                                     
selectList : Int -> Model -> Model
selectList id model =
    { model | selectedItem = getItemById model.items id }
                                    
addNewList : Model -> Model
addNewList model =
    case model.newListInputValue of
        "" -> model
        _ -> let id = 1 + List.length model.items
             in { model |
                  items = model.items ++ [{ itemId = id, name = model.newListInputValue, childItems = [] }]
                , newListInputValue = ""
                }                                   
