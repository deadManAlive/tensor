module Ndarray where

    -- generic n-dimensional array data structure with data, shape, and stride information
    data Tensor a = Tensor { arr :: [a]
                           , shape :: [Int]
                           , stride :: [Int]
                           }
    -- constructors and public methods
    mkTensor :: a -> [Int] -> Tensor a
    mkTensor elm sh = 
        Tensor (replicate (product sh) elm) sh (shapeToStride sh)

    mkZeros :: (Num a) => [Int] -> Tensor a
    mkZeros sh = mkTensor 0 sh

    mkFromList :: [a] -> [Int] -> Maybe (Tensor a)
    mkFromList arr sh
        | length arr /= product sh = Nothing
        | otherwise = Just (Tensor arr sh (shapeToStride sh))

    getItem:: Tensor a -> [Int] -> Maybe a
    getItem t idx
        | offset >= getLen t = Nothing
        | otherwise = Just ((getData t) !! offset)
        where
            offset = sum (zipWith (*) idx (getStride t))

    -- primitive methods (for debug & internal use)
    -- TODO: export only public functions above
    getData :: Tensor a -> [a]
    getData (Tensor arr _ _) = arr

    getLen :: Tensor a -> Int
    getLen (Tensor arr _ _) = length arr

    getShape :: Tensor a -> [Int]
    getShape (Tensor _ shape _) = shape

    getStride :: Tensor a -> [Int]
    getStride (Tensor _ _ stride) = stride

    shapeToStride :: [Int] -> [Int]
    shapeToStride shape = map calculateStride [0..length shape - 1]
        where
            calculateStride arr = product (drop (arr + 1) shape)

    indexToOffset :: Tensor a -> [Int] -> Int
    indexToOffset t idx = sum (zipWith (*) idx (getStride t))

    printTensor :: (Show a) => Tensor a -> IO ()
    printTensor t = do
        print (getLen t)
        print (getData t)
        print (getShape t)
        print (getStride t)

    