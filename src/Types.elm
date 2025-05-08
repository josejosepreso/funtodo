module Types exposing (..)

type alias Item =
    { itemId : Int
    , name : String
    , childItems : List String
    }
       
type alias Model =
    { items : List Item
    , newListInputValue : String
    , newItemInputValue : String
    , selectedItem : Maybe Item
    }
    
type Msg = Select Int
         | AddList
         | AddItem
         | ChangeNewListInput String
         | ChangeNewItemInput String    
