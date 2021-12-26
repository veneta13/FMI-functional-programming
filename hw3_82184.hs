import Data.List

-- Task 1

-- Create list of the consecutive pairs
makePairs :: [Int] -> [(Int, Int)]
makePairs [] = []
makePairs xs = zip xs (tail xs)

-- Create a list of the absolute difference of the pairs
findDifference :: [(Int, Int)] -> [Int]
findDifference [] = []
findDifference ((a, b):xs) = abs(a -  b) : findDifference xs

-- Get the last element of a list
lastElement :: [Int] -> Int
lastElement [x] = x
lastElement (_:xs) = lastElement xs

-- Check if the list is made of consecutive integers 
isConsecutive :: [Int] -> Bool
isConsecutive [] = True
isConsecutive xs = length xs == lastElement xs && isConsecutive (init xs)

-- main function
willItFly :: [Int] -> Bool
willItFly [] = True
willItFly xs = isConsecutive (sort (findDifference (makePairs xs)))


-- Task 2

-- get an array of values for each time period
getTime :: (Int,[Int])  -> (Int, [Int])
getTime (x, l)
    | null l = getTime (rem x 31536000,  [quot x 31536000])
    | length l == 1 = getTime (rem x 86400, l ++ [quot x 86400])
    | length l == 2 = getTime (rem x 3600, l ++ [quot x 3600])
    | length l == 3 = getTime (rem x 60, l ++ [quot x 60])
    | length l == 4 = (0, l ++ [rem x 60])

-- pluralize number name string if needed
pluralNoun :: (Int, String) -> String
pluralNoun (x, str)
    | x > 1 = show x ++ str ++ "s"
    | otherwise = show x ++ str

-- nullify already used value
nullifyAtPosition :: ([Int], Int) -> [Int]
nullifyAtPosition (xs, index) =
    [if i == index then 0 else x | (i, x) <- zip [0 .. ] xs]

-- get string of the value depending on array position
getString :: [Int] -> String
getString x
    | head x /= 0 = pluralNoun(head x, " year")
    | x!!1 /= 0 = pluralNoun(x!!1, " day")
    | x!!2 /= 0 = pluralNoun(x!!2, " hour")
    | x!!3 /= 0 = pluralNoun(x!!3, " minute")
    | x!!4 /= 0 = pluralNoun(x!!4, " second")

-- get index of the value
getIndex :: [Int] ->  Int
getIndex x
    | head x /= 0 = 0
    | x!!1 /= 0 = 1
    | x!!2 /= 0 = 2
    | x!!3 /= 0 = 3
    | x!!4 /= 0 = 4

-- create the time string
createTimeString :: [Int] -> String
createTimeString x
    | length (filter (/=0) x) == 1 = getString x
    | length (filter (/=0) x) == 2 = getString x ++ " and " ++  getString(nullifyAtPosition (x, getIndex x))
    | length (filter (/=0) x) > 2 = getString x ++ ", " ++  createTimeString(nullifyAtPosition (x, getIndex x))

-- main function
formatDuration :: Int -> String
formatDuration 0 = "now"
formatDuration x = createTimeString timeArray where
    timeArray = b where 
        (a,b) = getTime(x, [])
