import Data.List

-- Task 1

makePairs :: [Int] -> [(Int, Int)]
makePairs [] = []
makePairs xs = zip xs (tail xs)

findDifference :: [(Int, Int)] -> [Int]
findDifference [] = []
findDifference ((a, b):xs) = abs(a -  b) : findDifference xs

lastElement :: [Int] -> Int
lastElement [x] = x
lastElement (_:xs) = lastElement xs

isConsecutive :: [Int] -> Bool
isConsecutive [] = True 
isConsecutive xs = length xs == lastElement xs && isConsecutive (init xs)

willItFly :: [Int] -> Bool
willItFly [] = True
willItFly xs = isConsecutive (sort (findDifference (makePairs xs)))

-- Task 2