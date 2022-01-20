-- Task 1

outcomes :: [Outcome]
outcomes = [Outcome "Bismarck" "North Atlantic" "sunk",
            Outcome "California" "Surigao Strait" "ok",
            Outcome "Duke of York" "North Cape" "ok",
            Outcome "Fuso" "Surigao Strait" "sunk",
            Outcome "Hood" "North Atlantic" "sunk",
            Outcome "King George V" "North Atlantic" "ok",
            Outcome "Kirishima" "Guadalcanal" "sunk",
            Outcome "Prince of Wales" "North Atlantic" "damaged",
            Outcome "Rodney" "North Atlantic" "ok",
            Outcome "Schamhorst" "North Cape" "sunk",
            Outcome "South Dakota" "Guadalcanal" "damaged",
            Outcome "Tennessee" "Surigao Strait" "ok",
            Outcome "Washington" "Guadalcanal" "ok",
            Outcome "Prince of Wales" "Guadalcanal" "ok",
            Outcome "West Virginia" "Surigao Strait" "ok",
            Outcome "Yamashiro" "Surigao Strait" "sunk",
            Outcome "California" "Guadalcanal" "damaged"]

battles :: [Battle]
battles = [Battle "Guadalcanal" "1942-11-15",
           Battle "North Atlantic" "1941-05-25",
           Battle "North Cape" "1943-12-26",
           Battle "Surigao Strait" "1944-10-25"]

ships :: [Ship]
ships = [Ship "California" "Tennessee" 1921,
         Ship "Haruna" "Kongo" 1916,
         Ship "Hiei" "Kongo" 1914,
         Ship "Iowa" "Iowa" 1943,
         Ship "Kirishima" "Kongo" 1915,
         Ship "Kongo" "Kongo" 1913,
         Ship "Missouri" "Iowa" 1944,
         Ship "Musashi" "Yamato" 1942,
         Ship "New Jersey" "Iowa" 1943,
         Ship "North Carolina" "North Carolina" 1941,
         Ship "Ramillies" "Revenge" 1917,
         Ship "Renown" "Renown" 1916,
         Ship "Repulse" "Renown" 1916,
         Ship "Resolution" "Renown" 1916,
         Ship "Revenge" "Revenge" 1916,
         Ship "Royal Oak" "Revenge" 1916,
         Ship "Royal Sovereign" "Revenge" 1916,
         Ship "Tennessee" "Tennessee" 1920,
         Ship "Washington" "North Carolina" 1941,
         Ship "Wisconsin" "Iowa" 1944,
         Ship "Yamato" "Yamato" 1941,
         Ship "Yamashiro" "Yamato" 1947,
         Ship "South Dakota" "North Carolina" 1941,
         Ship "Bismarck" "North Carolina" 1911,
         Ship "Duke of York" "Renown" 1916,
         Ship "Fuso" "Iowa" 1940,
         Ship "Hood" "Iowa" 1942,
         Ship "Rodney" "Yamato" 1915,
         Ship "Yanashiro" "Yamato" 1918,
         Ship"Schamhorst" "North Carolina" 1917,
         Ship "Prince of Wales" "North Carolina" 1937,
         Ship "King George V" "Iowa" 1942,
         Ship"West Virginia" "Iowa" 1942 ]

database :: Database
database = (outcomes, battles, ships)

type Name = String
type Date = String
type Class = String
type Result = String
type Launched = Int

data Battle = Battle Name Date deriving Show
data Ship = Ship Name Class Launched deriving Show
data Outcome = Outcome Name Name Result deriving Show

type Database = ([Outcome], [Battle], [Ship])

getOutcomes :: Database -> [Outcome]
getOutcomes (a, _, _) = a

getBattles :: Database -> [Battle]
getBattles (_, a, _) = a

getShips :: Database -> [Ship]
getShips (_, _, a) = a

getBattleName :: Battle -> String
getBattleName (Battle a _) = a

getBattleDate :: Battle -> String
getBattleDate (Battle _ a) = a

getShipName :: Ship -> String
getShipName (Ship a _ _) = a

getShipClass :: Ship -> String
getShipClass (Ship _ a _) = a

getShipLaunched :: Ship -> Int
getShipLaunched (Ship _ _ a) = a

getOutcomeShipName :: Outcome -> String
getOutcomeShipName (Outcome a _ _) = a

getOutcomeBattleName :: Outcome -> String
getOutcomeBattleName (Outcome _ a _) = a

getOutcomeResult :: Outcome -> String
getOutcomeResult (Outcome _ _ a) = a

-- filters only outcomes with "sunk" result
onlySunkOutcomes :: [Outcome] -> [Outcome]
onlySunkOutcomes [] = []
onlySunkOutcomes (x:xs)
    | getOutcomeResult x == "sunk" = x:onlySunkOutcomes xs
    | otherwise = onlySunkOutcomes xs

-- filters battle names appearing more than once
filterBattleNames :: [Outcome] -> [String] -> [String]
filterBattleNames [] result = result
filterBattleNames (x:xs) result
    | getOutcomeBattleName x `elem` result = filterBattleNames xs result
    | otherwise = filterBattleNames xs (getOutcomeBattleName x : result)

-- gets the names of the ships by battle
getBattleShips :: [Outcome] -> String -> [String]
getBattleShips xs bName = [getOutcomeShipName x | x <- xs, getOutcomeBattleName x == bName]

-- make battle-ships pairs
makePairs :: [Outcome] -> [String] -> [(Name, [Name])]
makePairs [] _ = []
makePairs _ [] = []
makePairs outc (x:xs) = (x, getBattleShips outc x) : makePairs outc xs

getSunk :: Database -> [(Name, [Name])]
getSunk ([], _, _) = []
getSunk (_, [], _) = []
getSunk (_, _, []) = []
getSunk db = makePairs sunkOutcomes (filterBattleNames sunkOutcomes [])
    where
        sunkOutcomes = onlySunkOutcomes (getOutcomes db)

-- order battles by year
orderBattlesTime :: [Battle] -> [Battle] -> [Battle]
orderBattlesTime [] result = result
orderBattlesTime (x:xs) [] = orderBattlesTime xs [x]
orderBattlesTime (x:xs) result
    | getBattleDate x < getBattleDate (last result) 
        = orderBattlesTime xs (orderBattlesTime [x] (init result) ++ [last result])
    | otherwise = orderBattlesTime xs (result ++ [x])

-- check if ship is in battle
shipInBattle :: Database -> Battle -> String -> Bool
shipInBattle db b s 
    = not (null ([ x | x <- getBattleShips (getOutcomes db) (getBattleName b), x == s]))

-- check if ship is in any of the battles
shipInBattles :: Database -> [Battle] -> String -> Bool
shipInBattles db xs s
  = foldr (\ x -> (||) (shipInBattle db x s)) False xs

-- get the names of the damaged ships in a battle
getDamagedShips :: [Outcome] -> Battle -> [String]
getDamagedShips [] _ = []
getDamagedShips (x:xs) b
    | getOutcomeResult x == "damaged" && getOutcomeBattleName x == getBattleName b 
        = getOutcomeShipName x : getDamagedShips xs b
    | otherwise = getDamagedShips xs b

-- iterate battles
battleIterator :: Database -> [Battle] -> [String]
battleIterator db [] = []
battleIterator db (b:bs) 
    = [ s | s <- getDamagedShips (getOutcomes db) b, shipInBattles db bs s] ++ battleIterator db bs

inBattleAfterDamaged :: Database -> [Name]
inBattleAfterDamaged db = battleIterator db ordBattles
    where ordBattles = orderBattlesTime (getBattles db) []

-- Task 2

aTree = Node 10
            (Node 5
                Nil
                (Node 7 Nil Nil))
            (Node 15
                (Node 13 Nil Nil)
                Nil)

bTree = Node 15
            (Node 5
                (Node 21 Nil Nil)
                (Node 16 Nil Nil))
            (Node 20
                Nil
                (Node 19 Nil Nil))

cTree = Node 15
                (Node 5
                    (Node 21 Nil Nil)
                    (Node 16
                        (Node 6 Nil Nil)
                        Nil))
                (Node 20
                    Nil
                    (Node 19 Nil Nil))

dTree = Node 15
                (Node 5
                    (Node 21 Nil Nil)
                    (Node 16
                        (Node 2 Nil Nil)
                        Nil))
                (Node 20
                    Nil
                    (Node 19 Nil Nil))

eTree = Node 1
                (Node (-1)
                    (Node 2 Nil Nil)
                    (Node 2
                        (Node 0 Nil Nil)
                        Nil))
                (Node (-1) Nil Nil)

fTree = Node 1
                (Node 2
                    (Node 1 Nil Nil)
                    (Node 1
                        (Node 10 Nil Nil)
                        Nil))
                (Node 3 Nil Nil)

data BTree = Nil | Node Int BTree BTree

checkChildren :: Int -> BTree -> BTree -> Bool
checkChildren x Nil Nil = True
checkChildren x (Node c _ _) Nil = c > x
checkChildren x Nil (Node c _ _) = c > x
checkChildren x (Node c1 _ _) (Node c2 _ _) = c1 > x && c2 > x

checkGrandchildren :: Int -> BTree -> Bool
checkGrandchildren x Nil = True
checkGrandchildren x (Node _ t1 t2) = checkChildren x t1 t2

grandchildrenIncreased :: BTree -> Bool
grandchildrenIncreased Nil = True
grandchildrenIncreased (Node x Nil Nil) = True
grandchildrenIncreased (Node x t1 t2) = checkGrandchildren x t1 && checkGrandchildren x t2 && grandchildrenIncreased t1 && grandchildrenIncreased t2
