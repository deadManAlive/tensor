module Ndarray where

    -- generic n-dimensional array data structure with data, shape, and stride information
    data Tensor a where
        Tensor :: Num a => { tarr :: [a]
                           , tshape :: [Int]
                           , tstride :: [Int]
                           } -> Tensor a

    -- constructors and public methods
    mkTensor :: Num a => a -> [Int] -> Tensor a
    mkTensor elm sh = 
        Tensor (replicate (product sh) elm) sh (shapeToStride sh)

    mkZeros :: Num a => [Int] -> Tensor a
    mkZeros sh = mkTensor 0 sh

    mkFromList :: Num a => [a] -> [Int] -> Maybe (Tensor a)
    mkFromList arr sh
        | length arr /= product sh = Nothing
        | otherwise = Just (Tensor arr sh (shapeToStride sh))

    getItem:: Tensor a -> [Int] -> Maybe a
    getItem t idx
        | offset >= tlen t = Nothing
        | otherwise = Just ((tarr t) !! offset)
        where
            offset = sum (zipWith (*) idx (tstride t))

    -- primitive methods (for debug & internal use)
    -- TODO: export only public functions above
    tlen :: Tensor a -> Int
    tlen (Tensor arr _ _) = length arr

    shapeToStride :: [Int] -> [Int]
    shapeToStride shape = map calculateStride [0..length shape - 1]
        where
            calculateStride arr = product (drop (arr + 1) shape)

    indexToOffset :: Tensor a -> [Int] -> Int
    indexToOffset t idx = sum (zipWith (*) idx (tstride t))

    printTensor :: (Show a) => Tensor a -> IO ()
    printTensor t = do
        print (tlen t)
        print (tarr t)
        print (tshape t)
        print (tstride t)

    