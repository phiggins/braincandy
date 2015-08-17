import System.Environment
import Data.List
import Data.Ord

getAnswers :: [String] -> IO [String]
getAnswers (x:_) = do
  l <- readFile x
  return $ lines l
getAnswers [] = do
  return [ "ABCCADCB",
           "DDDCAACB",
           "ABDDABCB",
           "AADCAACC",
           "BBDDAACB",
           "ABDCCABB",
           "ABDDCACB" ]

getAnswerKeyFromAnswers           :: [String] -> String
getAnswerKeyFromAnswers answers   = map mostCommon $ transpose answers

mostCommon    :: String -> Char
mostCommon s  = head $ maximumBy (comparing length) (group $ sort s)

main = do
  args <- getArgs
  answers <- getAnswers args

  putStrLn $ getAnswerKeyFromAnswers answers
