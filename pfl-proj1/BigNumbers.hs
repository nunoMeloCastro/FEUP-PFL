
module BigNumbers (BigNumber,
scanner, output, somaBN, subBN) where
import Data.Char


-- 2.1
data Signal = Neg | Pos | Zero deriving (Eq, Ord, Show)

type Digits = [Int]

data BigNumber = BigNumber {signal :: Signal, number :: Digits} deriving (Eq, Ord, Show)


-- 2.2
scanner :: String -> BigNumber
scanner str
    | head str == '-' = BigNumber Neg [digitToInt c | c <- reverse (tail str)]
    | otherwise = BigNumber Pos [digitToInt c | c <- reverse str]


-- 2.3
output :: BigNumber -> String
output (BigNumber Pos l) = reverse (concat [show x | x <- l])
output (BigNumber Neg l) = '-' : reverse (concat [show x | x <- l])


-- 2.4
somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN (BigNumber Pos bn1) (BigNumber Zero [0]) = BigNumber Pos bn1
somaBN (BigNumber Zero [0]) (BigNumber Pos bn1) = BigNumber Pos bn1
somaBN (BigNumber Neg bn1) (BigNumber Zero [0]) = BigNumber Neg bn1
somaBN (BigNumber Zero [0]) (BigNumber Neg bn1) = BigNumber Neg bn1
somaBN (BigNumber Pos bn1) (BigNumber Pos bn2) = soma (BigNumber Pos bn1) (BigNumber Pos bn2) 0
somaBN (BigNumber Neg bn1) (BigNumber Neg bn2) = convertToNeg $ soma (convertToPos (BigNumber Neg bn1)) (convertToPos (BigNumber Neg bn2)) 0
somaBN (BigNumber Pos bn1) (BigNumber Neg bn2) = subBN (BigNumber Pos bn1) (BigNumber Pos bn2)
somaBN (BigNumber Neg bn1) (BigNumber Pos bn2) = subBN (BigNumber Pos bn2) (BigNumber Pos bn1)


-- Function used to sum positive and negative BigNumbers since the sum is the same thing
soma :: BigNumber -> BigNumber -> Int -> BigNumber
soma (BigNumber Pos []) (BigNumber Pos []) 0 = BigNumber Pos []
soma (BigNumber Pos []) (BigNumber Pos []) acc = BigNumber Pos [acc]
soma (BigNumber Pos l) (BigNumber Pos []) 0 = BigNumber Pos l
soma (BigNumber Pos []) (BigNumber Pos l) 0 = BigNumber Pos l
soma (BigNumber Pos (x:xs)) (BigNumber Pos []) acc = BigNumber Pos [mod (x + acc) 10] +++ soma (BigNumber Pos (xs)) (BigNumber Pos []) (div (x + acc) 10)
soma (BigNumber Pos []) (BigNumber Pos (x:xs)) acc = BigNumber Pos [mod (x + acc) 10] +++ soma (BigNumber Pos []) (BigNumber Pos (xs)) (div (x + acc) 10)
soma (BigNumber Pos (x:xs)) (BigNumber Pos (y:ys)) acc
    | acc == 0 = BigNumber Pos [(x + y) `mod` 10] +++ soma (BigNumber Pos xs) (BigNumber Pos ys) ((x + y) `div` 10)
    | otherwise = BigNumber Pos [(x + y + acc) `mod` 10] +++ soma (BigNumber Pos xs) (BigNumber Pos ys) (div (x + y + acc) 10)


-- 2.5
subBN :: BigNumber -> BigNumber -> BigNumber
-- Subtraction between 2 positive numbers
subBN (BigNumber Pos bn1) (BigNumber Pos bn2)
    | bn1 == bn2 = BigNumber Zero [0]
    | getLarger (BigNumber Pos bn1) (BigNumber Pos bn2) == BigNumber Pos bn2 = convertToNeg $ sub (BigNumber Pos bn2) (BigNumber Pos bn1)--}
    | otherwise = sub (BigNumber Pos bn1) (BigNumber Pos bn2)
-- Subtraction between 2 negative numbers
subBN (BigNumber Neg bn1) (BigNumber Neg bn2)
    | bn1 == bn2 = BigNumber Zero [0]
    | getLarger (BigNumber Neg bn1) (BigNumber Neg bn2) == BigNumber Neg bn2 = convertToNeg $ sub (BigNumber Pos bn1) (BigNumber Pos bn2)
    | otherwise = sub (BigNumber Pos bn2) (BigNumber Pos bn1)
-- Subtraction between 1 positive and 1 negative number => Sum between 2 positive numbers
subBN (BigNumber Pos bn1) (BigNumber Neg bn2) = somaBN (BigNumber Pos bn1) (BigNumber Pos bn2)
-- Subtraction between 1 negative and 1 positive number
subBN (BigNumber Neg bn1) (BigNumber Pos bn2) = convertToNeg $ somaBN (BigNumber Pos bn1) (BigNumber Pos bn2)


sub :: BigNumber -> BigNumber -> BigNumber
sub (BigNumber Pos l) (BigNumber Pos []) = BigNumber Pos l
sub (BigNumber Pos []) (BigNumber Pos l) = BigNumber Pos l
sub (BigNumber Pos (x:xs)) (BigNumber Pos (y:ys))
    | x == y = removeZero $ BigNumber Pos [0] +++ sub (BigNumber Pos xs) (BigNumber Pos ys)
    | x > y = removeZero $ BigNumber Pos [x-y] +++ sub (BigNumber Pos xs) (BigNumber Pos ys)
    | otherwise = removeZero $ BigNumber Pos [(10+x) - y] +++ sub (BigNumber Pos xs) (BigNumber Pos ((1 + myHead ys) : myTail ys))


-- 2.6
mulBN :: BigNumber -> BigNumber -> BigNumber
-- Zero is the absorbing element of the multiplication
mulBN (BigNumber _ bn1) (BigNumber Zero [0]) = BigNumber Zero [0]
mulBN (BigNumber Zero [0]) (BigNumber _ bn1) = BigNumber Zero [0]
-- Other cases
mulBN (BigNumber Pos x) (BigNumber Pos y) = mul (BigNumber Pos x) (BigNumber Pos y)
mulBN (BigNumber Neg x) (BigNumber Neg y) = mul (BigNumber Pos x) (BigNumber Pos y)
mulBN (BigNumber Pos x) (BigNumber Neg y) = convertToNeg $ mul (BigNumber Pos x) (BigNumber Pos y)
mulBN (BigNumber Neg x) (BigNumber Pos y) = convertToNeg $ mul (BigNumber Pos x) (BigNumber Pos y)


mul :: BigNumber -> BigNumber -> BigNumber
-- In case [] is an input
mul (BigNumber Pos []) (BigNumber Pos x) = BigNumber Pos []
mul (BigNumber Pos x) (BigNumber Pos []) = BigNumber Pos []
-- Other cases
mul (BigNumber Pos (x:xs)) (BigNumber Pos y) = somaBN (mulAux x (BigNumber Pos y) 0) (BigNumber Zero [0] +++ mul (BigNumber Pos xs) (BigNumber Pos y))


mulAux :: Int -> BigNumber -> Int -> BigNumber
mulAux n (BigNumber Pos []) 0 = BigNumber Pos []
mulAux n (BigNumber Pos []) acc = BigNumber Pos [acc]
mulAux n (BigNumber Pos (x:xs)) acc
  | acc == 0 = BigNumber Pos [(n * x) `mod` 10] +++ mulAux n (BigNumber Pos xs) ((n * x) `div` 10)
  | otherwise = BigNumber Pos [(n * x + acc) `mod` 10] +++ mulAux n (BigNumber Pos xs) (div (n * x + acc) 10)


-- 2.7
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN (BigNumber Zero [0]) (BigNumber Pos bn2) = (BigNumber Zero [0], BigNumber Zero [0])
divBN (BigNumber Pos bn1) (BigNumber Pos bn2)
    | bn1 == bn2 = (BigNumber Pos [1], BigNumber Zero [0])
    | getLarger (BigNumber Pos bn1) (BigNumber Pos bn2) == BigNumber Pos bn2 = (BigNumber Zero [0], BigNumber Pos bn1)
    | otherwise = (quotient, rest)
        where quotient = divAux (BigNumber Pos bn1) (BigNumber Pos bn2) 0
              rest = subBN (BigNumber Pos bn1) (mulBN (BigNumber Pos bn2) (quotient))


divAux :: BigNumber -> BigNumber -> Int -> BigNumber
divAux (BigNumber Pos bn1) (BigNumber Pos bn2) cnt 
    | (BigNumber Pos bn1) == (mulAux cnt (BigNumber Pos bn2) 0) = scanner (show cnt)
    | getLarger (BigNumber Pos bn1) (mulAux cnt (BigNumber Pos bn2) 0) == (mulAux cnt (BigNumber Pos bn2) 0) = scanner (show (cnt - 1))
    | otherwise = divAux (BigNumber Pos bn1) (BigNumber Pos bn2) (cnt + 1)


myLast :: [BigNumber] -> BigNumber
myLast [] = BigNumber Zero [0]
myLast l = last l


-- 3
fibRecBN :: BigNumber -> BigNumber
fibRecBN (BigNumber Zero [0]) = BigNumber Zero [0]
fibRecBN (BigNumber Pos [1]) = BigNumber Pos [1]
fibRecBN (BigNumber Pos bn) = somaBN (fibRecBN $ subBN (BigNumber Pos bn) (BigNumber Pos [2])) (fibRecBN $ subBN (BigNumber Pos bn) (BigNumber Pos [1]))


fibListaBN :: BigNumber -> BigNumber
fibListaBN (BigNumber Zero [0]) = BigNumber Zero [0]
fibListaBN (BigNumber Pos [1]) = BigNumber Pos [1]
fibListaBN (BigNumber sig bn) = x !! convertToInt (BigNumber sig bn)
    where x =  generateListaBN [BigNumber Zero [0], BigNumber Pos [1]] (BigNumber sig bn)


generateListaBN :: [BigNumber] -> BigNumber -> [BigNumber]
generateListaBN lista (BigNumber sig bn)
    | bn == [0] = [head lista]
    | bn == [1] = lista
    | otherwise = generateListaBN (lista ++ [somaBN (last lista) (lista !! (length lista - 2))]) (subBN (BigNumber sig bn) (BigNumber Pos [1]))


fibListaInfinitaBN :: BigNumber -> BigNumber
fibListaInfinitaBN (BigNumber sig bn) = lista !! convertToInt (BigNumber sig bn)
    where lista = BigNumber Zero [0] : BigNumber Pos [1] : zipWith somaBN lista (tail lista)


-- 5
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
safeDivBN (BigNumber sig1 bn1) (BigNumber sig2 bn2)
    | sig2 == Zero = Nothing
    | otherwise = Just (divBN (BigNumber sig1 bn1) (BigNumber sig2 bn2))


-- Auxiliar Functions
convertToPos :: BigNumber -> BigNumber
convertToPos (BigNumber Neg l) = BigNumber Pos l


convertToNeg :: BigNumber -> BigNumber
convertToNeg (BigNumber Pos l) = BigNumber Neg l


convertToInt :: BigNumber -> Int
convertToInt (BigNumber Zero [0]) = 0
convertToInt (BigNumber Pos bn) = read $ map intToDigit (reverse bn)
convertToInt (BigNumber Neg bn) = negate (read (map intToDigit (reverse bn)))


getLarger :: BigNumber -> BigNumber -> BigNumber
getLarger (BigNumber Zero [0]) (BigNumber Pos bn1) = BigNumber Pos bn1
getLarger (BigNumber Pos bn1) (BigNumber Zero [0]) = BigNumber Pos bn1
getLarger (BigNumber Zero [0]) (BigNumber Neg bn1) = BigNumber Zero [0]
getLarger (BigNumber Neg bn1) (BigNumber Zero [0]) = BigNumber Zero [0]
-- Compare 2 positive BigNumbers
getLarger (BigNumber Pos bn1) (BigNumber Pos bn2)
    | length bn1 > length bn2 = BigNumber Pos bn1
    | length bn1 < length bn2 = BigNumber Pos bn2
    | getLargerAux (BigNumber Pos (reverse bn1)) (BigNumber Pos (reverse bn2)) == True = (BigNumber Pos bn1)
    | getLargerAux (BigNumber Pos (reverse bn1)) (BigNumber Pos (reverse bn2)) == False = (BigNumber Pos bn2)
-- Compare 2 negative BigNumbers (it's the inverse of the previous)
getLarger (BigNumber Neg bn1) (BigNumber Neg bn2)
    | length bn1 > length bn2 = BigNumber Neg bn2
    | length bn1 < length bn2 = BigNumber Neg bn1
    | getLargerAux (BigNumber Neg (reverse bn1)) (BigNumber Neg (reverse bn2)) == True = (BigNumber Neg bn1)
    | getLargerAux (BigNumber Neg (reverse bn1)) (BigNumber Neg (reverse bn2)) == False = (BigNumber Neg bn2)
-- Compare numbers with opposite signal: positive number is always larger
getLarger (BigNumber Pos bn1) (BigNumber Neg bn2) = BigNumber Pos bn1
getLarger (BigNumber Neg bn1) (BigNumber Pos bn2) = BigNumber Pos bn2


getLargerAux :: BigNumber -> BigNumber -> Bool
getLargerAux (BigNumber Pos bn1) (BigNumber Pos []) = True
getLargerAux (BigNumber Pos []) (BigNumber Pos bn2) = False
getLargerAux (BigNumber Pos (x:xs)) (BigNumber Pos (y:ys))
    | x == y = getLargerAux (BigNumber Pos (xs)) (BigNumber Pos (ys))
    | x > y = True
    | otherwise = False


myHead :: [Int] -> Int
myHead [] = 0
myHead l = head l


myTail :: [Int] -> [Int]
myTail [] = []
myTail l = tail l


(+++) :: BigNumber -> BigNumber -> BigNumber
(+++) (BigNumber Zero [0]) (BigNumber Pos l) = BigNumber Pos (0 : l)
(+++) (BigNumber Pos []) (BigNumber Pos l) = BigNumber Pos l
(+++) (BigNumber Pos (x:xs)) (BigNumber Pos ys) = BigNumber Pos (x:(xs++ys))


-- Used in sub function in order to remove an unwanted zero in the beginning of the number
removeZero :: BigNumber -> BigNumber
removeZero (BigNumber Pos bn) = if last bn == 0 then BigNumber Pos (init bn) else BigNumber Pos bn
