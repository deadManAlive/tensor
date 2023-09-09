import Ndarray

main :: IO ()
main =
  print mt
    >> print (indexToOffset <$> mt <*> Just offset)
  where
    mt = mkFromList [1, 2, 3, 4, 5, 6, 7, 8] [2, 2, 2]
    offset = [0, 0, 1]
