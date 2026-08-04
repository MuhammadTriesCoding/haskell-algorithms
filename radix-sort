module RadixSort (radixSort) where

-- LSD (Least Significant Digit) Radix Sort for non-negative integers.
--
-- The list is passed through one stable counting-sort pass per digit
-- position, starting from the least significant digit and working up
-- to the most significant digit of the largest number in the list.

radixSort :: [Int] -> [Int]
radixSort [] = []
radixSort xs
  | any (< 0) xs = error "radixSort: only supports non-negative integers"
  | otherwise     = foldl sortByDigit xs [0 .. numDigits (maximum xs) - 1]

-- Number of digits in a non-negative integer (0 counts as one digit).
numDigits :: Int -> Int
numDigits 0 = 1
numDigits n = length (show n)

-- The digit at a given position, where position 0 is least significant.
digitAt :: Int -> Int -> Int
digitAt pos n = (n `div` (10 ^ pos)) `mod` 10

-- One stable counting-sort pass on a single digit position.
-- Bucketing by digit 0..9 and concatenating in order keeps the sort stable,
-- which is what makes repeated passes over each digit correct.
sortByDigit :: [Int] -> Int -> [Int]
sortByDigit xs pos = concatMap (\d -> filter (\x -> digitAt pos x == d) xs) [0 .. 9]

main :: IO ()
main = do
  let sample = [170, 45, 75, 90, 802, 24, 2, 66]
  putStrLn ("Input:  " ++ show sample)
  putStrLn ("Sorted: " ++ show (radixSort sample))
