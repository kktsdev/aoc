module Main where

import qualified Part1
import qualified Part2

main :: IO ()
main = do
  input <- lines <$> getContents
  putStr $
       "Part 1: " ++ show (Part1.solve input) ++ "\n"
    ++ "Part 2: " ++ show (Part2.solve input) ++ "\n"