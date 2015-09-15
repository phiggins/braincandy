import System.Environment

height :: [String] -> Int
height (x:_) = read x
height []    = 10

pascalsTriangle :: Int -> [[Int]]
pascalsTriangle n = map (\i -> map (pascalAt i) [0..i]) [0..n-1]
  where pascalAt row column
          | column < 1    = 1
          | column == row = 1
          | otherwise     = (pascalAt (row-1) (column-1)) + (pascalAt (row-1) column)

main = do
  args <- getArgs

  mapM_ print $ pascalsTriangle (height args)
