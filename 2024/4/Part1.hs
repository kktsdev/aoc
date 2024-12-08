module Part1 (solve) where

import Data.Ix (inRange)

directions :: [(Int, Int)]
directions = [ (0, 1), (0, -1), (1, 0), (-1, 0)
             , (1, 1), (1, -1), (-1, 1), (-1, -1) ]

search :: [[Char]] -> (Int, Int) -> (Int, Int) -> Bool
search grid (x, y) (dx, dy) = all isValid [0..3]
  where
    isValid n = let
        (nx, ny) = (x + dx * n, y + dy * n)
        (rx, ry) = ((length grid - 1, length (head grid) - 1))
      in
        inRange ((0, 0), (rx, ry)) (nx, ny)
        && (grid !! nx !! ny) == "XMAS" !! n

solve :: [[Char]] -> Int
solve grid =
  sum [length [()
      | dir <- directions
      , search grid (x, y) dir]
      | x <- [0..length grid - 1]
      , y <- [0..length (head grid) - 1]
      , grid !! x !! y == 'X']