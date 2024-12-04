module Main where

import Text.Regex.TDFA

data Operation
  = Do
  | Don't
  | Mul (Int, Int)
  deriving Show

parse :: String -> [Operation]
parse input = map p $ input =~ reg
  where reg = "mul\\(([0-9]+),([0-9]+)\\)|don't\\(\\)|do\\(\\)"
        p ["do()", _, _] = Do
        p ["don't()", _, _] = Don't
        p [_, x, y] = Mul (read x, read y)

eval :: [Operation] -> Int
eval = fst . foldl f (0, True)
  where f :: (Int, Bool) -> Operation -> (Int, Bool)
        f (n, _) Do = (n, True)
        f (n, _) Don't = (n, False)
        f (n, True) (Mul(x, y)) = (x * y + n, True)
        f (n, False) (Mul(_, _)) = (n, False)

solve :: String -> Int
solve = eval . filter isMul . parse
  where isMul (Mul _) = True
        isMul _ = False

solve2 :: String -> Int
solve2 = eval . parse

main :: IO()
main = do
  input <- getContents
  putStr $
       "Part 1: " ++ show (solve input) ++ "\n"
    ++ "Part 2: " ++ show (solve2 input) ++ "\n"