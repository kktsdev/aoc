import Data.List (group, sort)
import Data.Map (fromListWith, (!?), Map)

totalDistance :: [Int] -> [Int] -> Int
totalDistance listl listr =
  sum $ zipWith (\a b -> abs (a - b)) (sort listl) (sort listr)

countElements :: [Int] -> Map Int Int
countElements = fromListWith (+) . flip zip (repeat 1)

similarityScore :: [Int] -> [Int] -> Int
similarityScore listl listr =
  let count = countElements listr
  in sum [x * maybe 0 id (count !? x) | x <- listl]

main :: IO ()
main = do
  file <- readFile "input"
  let (listl, listr) = unzip $ map ((\[l, r] -> (read l, read r)) . words) (lines file)
  putStr $
       "Part 1: " ++ show (totalDistance listl listr) ++ "\n"
    ++ "Part 2: " ++ show (similarityScore listl listr) ++ "\n"