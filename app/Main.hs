module Main where

import Parser (parseFormula)
import Models (Formula(..))

main :: IO ()
main = do
    putStrLn "Insira a fórmula:"
    entrada <- getLine
    case parseFormula entrada of
        Left erro -> print erro
        Right formula -> print formula