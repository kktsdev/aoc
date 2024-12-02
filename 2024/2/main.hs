import Data.List (tails)

isSafe :: [Int] -> Bool
isSafe levels =
  all validDiff pairs && (increasing || decreasing)
  where
    pairs = zip levels (tail levels)
    validDiff (x, y) = abs (x - y) >= 1 && abs (x - y) <= 3
    increasing = all (\(x, y) -> x < y) pairs
    decreasing = all (\(x, y) -> x > y) pairs

isSafeFix :: [Int] -> Bool
isSafeFix levels =
  isSafe levels || any (isSafe . removeAt levels) [0 .. length levels - 1]
  where
    removeAt :: [Int] -> Int -> [Int]
    removeAt xs i = take i xs ++ drop (i + 1) xs

countSafe :: [[Int]] -> Int
countSafe reports = length $ filter isSafe reports

countSafeFix :: [[Int]] -> Int
countSafeFix reports = length $ filter isSafeFix reports

main :: IO ()
main = do
  file <- readFile "input"
  let reports = map (map read . words) (lines file)
  putStr $
       "Part 1: " ++ show (countSafe reports) ++ "\n"
    ++ "Part 2: " ++ show (countSafeFix reports) ++ "\n"