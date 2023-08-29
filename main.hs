import Ndarray

main :: IO ()
main = do
    let m = mkFromList [1, 2, 3, 4, 5, 6, 7, 8] [2, 2, 2]
    let index = [0, 1, 1] in
        case m of
            Nothing -> print "Failed in generating tensor"
            Just t -> do
                print (getLen t)
                print (indexToOffset t index)
                print (getItem t index)
