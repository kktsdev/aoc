module Part2 (solve) where

import Data.Ix (inRange)

type Pattern = (Char, Char, Char, Char)

directions :: [(Int, Int)]
directions = [(-1, -1), (-1, 1), (1, -1), (1, 1)]

patterns :: [Pattern]
patterns = [ ('M', 'M', 'S', 'S')
           , ('M', 'S', 'M', 'S')
           , ('S', 'M', 'S', 'M')
           , ('S', 'S', 'M', 'M') ]

matchPattern :: [[Char]] -> (Int, Int) -> Pattern -> Bool
matchPattern grid (x, y) (a, b, c, d) =
  all (\((dx, dy), char) ->
    let
      (nx, ny) = (x + dx, y + dy)
      (rx, ry) = ((length grid - 1, length (head grid) - 1))
    in inRange (0, rx) nx &&
       inRange (0, ry) ny &&
       grid !! nx !! ny == char)
    (zip directions [a, b, c, d])

search :: [[Char]] -> (Int, Int) -> Bool
search grid (x, y)
  | grid !! x !! y /= 'A' = False
  | otherwise = any (matchPattern grid (x, y)) patterns

solve :: [[Char]] -> Int
solve grid =
  sum [1
      | x <- [0..length grid - 1]
      , y <- [0..length (head grid) - 1]
      , search grid (x, y)]