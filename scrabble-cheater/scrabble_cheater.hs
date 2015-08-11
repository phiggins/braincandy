import System.Environment
import Data.Char
import Data.List

getInputChars :: [String] -> String
getInputChars [] = "tacocat"
getInputChars (x:xs) = x

matchingWords :: String -> [String] -> [String]
matchingWords chars words = filter (\w -> null (w \\ chars)) words

matchingWordsFromDict :: String -> FilePath -> IO [String]
matchingWordsFromDict chars dict = do
  words <- readFile dict
  return (matchingWords chars (lines (map toLower words)))

main = do
  input <- getArgs
  let input_chars = getInputChars input

  putStr "Using input characters: "
  putStrLn $ intersperse ',' input_chars
  putStrLn ""

  --raw_words <- readFile "dictionary.txt"
  --let words = lines $ map toLower raw_words

  matching_words <- matchingWordsFromDict input_chars "dictionary.txt"

  putStrLn "Found matching words:"
  --mapM_ putStrLn (matchingWords input_chars words)
  mapM_ putStrLn matching_words
