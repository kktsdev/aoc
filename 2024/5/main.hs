module Main where

import Data.List (lines, words, elemIndex)
import Data.List.Split (splitOn)
import Data.Maybe (fromJust)

data Rule = Rule Int Int deriving (Eq, Show)
data Update = Update [Int] deriving (Eq, Show)

parseRules :: String -> [Rule]
parseRules s = map parseRule $ lines s
  where
    parseRule :: String -> Rule
    parseRule s = case splitAt (length s `div` 2) s of
      (x, '|' : y) -> Rule (read x) (read y)
      _ -> error $ "Invalid rule: " ++ s

parseUpdates :: String -> [Update]
parseUpdates s = map parseUpdate $ lines s
  where
    parseUpdate :: String -> Update
    parseUpdate s = Update $ map read $ splitOn "," s

parseInput :: String -> ([Rule], [Update])
parseInput s = let rules = takeWhile (/= "") (lines s)
                   updates = drop (length rules + 1) (lines s)
               in (parseRules (unlines rules), parseUpdates (unlines updates))

isCorrectlyOrdered :: [Rule] -> Update -> Bool
isCorrectlyOrdered rules (Update pages) =
  all (\(Rule x y) ->
    (x `elem` pages
    && y `elem` pages
    && (fromJust (elemIndex x pages) < fromJust (elemIndex y pages)))
    || (not (x `elem` pages)
    || not (y `elem` pages)))
    rules

getMiddlePage :: Update -> Int
getMiddlePage (Update pages) = pages !! (length pages `div` 2)

solve :: ([Rule], [Update]) -> Int
solve (rules, updates) =
  let correctlyOrderedUpdates = filter (isCorrectlyOrdered rules) updates
      middlePages = map getMiddlePage correctlyOrderedUpdates
  in sum middlePages

main :: IO ()
main = do
  input <- getContents
  let (rules, updates) = parseInput input
  putStr $
    "Part 1: " ++ show (solve (rules, updates)) ++ "\n"