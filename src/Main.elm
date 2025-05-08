module Main exposing (..)

import Browser
import View exposing (view)
import State exposing (init, update)

main = Browser.sandbox { init = init
                       , update = update
                       , view = view
                       }
