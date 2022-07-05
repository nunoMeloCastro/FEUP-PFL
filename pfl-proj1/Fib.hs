
-- 1.1
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec(n-2) + fibRec(n-1)


-- 1.2
fibLista :: (Integral a) => a -> a
fibLista 0 = 0
fibLista 1 = 1
fibLista n = x !! fromIntegral n
    where x = generateLista [0,1] n


generateLista :: (Integral a) => [a] -> a -> [a]
generateLista lista n
    | n == 0 = [head lista]
    | n == 1 = lista
    | otherwise = generateLista (lista ++ [last lista + lista !! (length lista - 2)]) (n-1)


-- 1.3
fibListaInfinita ::(Integral a) => a -> a
fibListaInfinita n = lista !! fromIntegral n
    where lista = 0 : 1 : zipWith (+) lista (tail lista)
