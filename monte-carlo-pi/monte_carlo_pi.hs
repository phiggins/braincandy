import System.Environment
import System.Random

rounds :: [String] -> Int
rounds (x:_) = read x
rounds []    = 100

approximatePi :: [Float] -> Int -> Float
approximatePi gen rounds = 4.0 * hits / total
  where hits = fromIntegral $ circlePoints gen rounds
        total = fromIntegral rounds

circlePoints :: [Float] -> Int -> Int
circlePoints gen rounds = length $ filter insideCircle (take rounds (points gen))
  where points (x:y:rest) = (x,y):(points rest)

insideCircle :: (Float, Float) -> Bool
insideCircle (x,y) = x**2 + y**2 < 1

main = do
  args <- getArgs
  gen <- newStdGen

  putStrLn $ show $ approximatePi (randoms gen) (rounds args)
