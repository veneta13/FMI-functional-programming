# FMI-functional-programming

Tasks for the functional programming course @ FMI.

### Homework 1

#### Task 1

Define a procedure **(sum-counts-iter x d)** that returns the sum of the digits of the number of occurrences of the digit d in the numbers from the interval [1, x]. The procedure must implement a linearly iterative process.

```racket
  (sum-counts-iter 1 1) ; → 1
  (sum-counts-iter 5123 1) ; → 19
  (sum-counts-iter 1234 8) ; → 10
  (sum-counts-iter 5555 5) ; → 10
  (sum-counts-iter 65432 6) ; → 11
  (sum-counts-iter 70000 1) ; → 11
  (sum-counts-iter 123321 1) ; → 29
```

#### Task 2

Define a procedure **(add-ones n)** that adds 1 to each digit of the non-negative number n. In case 1 to 9 is added instead of done carry 1, add 10 to the new number.

```racket
  (add-ones 123) ; → 234
  (add-ones 193) ; → 2104
  (add-ones 998) ; → 10109
  (add-ones 9999) ; → 10101010
```

### Homework 2

#### Task 1

Define a higher-order procedure **(itinerary flights)**, which accepts a list of pairs representing air travel in the form **(&lt;start>.&lt;end>)**, and returns a unary procedure accepting the initial airport - such that the value of **((itinerary flights) start)** is lexicographically the smallest sequence of travels that includes all given trips exactly once (it is possible to go through one airport more than once). If case such does not exist,  return error indication.

```racket
((itinerary '(("SFO" . "HKO") ("YYZ" . "SFO") ("YUL" . "YYZ")("HKO" . "ORD"))) "YUL") ; → '("YUL" "YYZ" "SFO" "HKO" "ORD")
((itinerary '(("A" . "B") ("A" . "C") ("B" . "C") ("C" . "A"))) "A") ; → '("A" "B" "C" "A" "C")
((itinerary '(("SFO" . "COM") ("COM" . "YYZ"))) "COM") ; → "No such itinerary!"
```

#### Task 2

Define a higher-order procedure **(pad xs)** that accepts a matrix xs and returns a unary procedure that takes the number x - such that the return value is a new matrix in which xs is enclosed by x.

```racket
((pad '( (1 2 3)
         (4 5 6)
         (7 8 9) )
         ) 0)

;→ '( (0 0 0 0 0)
;     (0 1 2 3 0)
;     (0 4 5 6 0)
;     (0 7 8 9 0)
;     (0 0 0 0 0) )

((pad '( (1 2 3)
         (4 5 6)
         (7 8 9) )
         ) 9)

;→ '( (9 9 9 9 9)
;     (9 1 2 3 9)
;     (9 4 5 6 9)
;     (9 7 8 9 9)
;     (9 9 9 9 9) )
```

### Homework 3

#### Task 1

While preparing the presents for Christmas, Santa's elves realized that they had a problem: the presents had to be arranged in a special way in the sleigh so that it could fly in the air. Each gift has a unique number - an integer. The goal is for the absolute values ​​of the differences between the numbers of every two adjacent gifts to occupy all values ​​between 1 and n-1, where n is the number of gifts to order. Although elves can come up with combinations of arrangements, there are too many gifts to judge whether they will be able to arrange them correctly the first time. Help them by defining the predicate **willItFly :: [Int] -> Bool**, which receives an ordinance proposed by the elves and checks if it is valid.

```haskell
willItFly [1, 4, 2, 3] ➝ True      -- |1-4|=3,|4-2|=2,|2-3|=1

willItFly [1, 4, 2, -1, 6] ➝ False -- |1-4|=3,|4-2|=2,|2-(-1)|=3, |-1-6|=7
```

#### Task 2

However, finding the right order for gifts was not the only problem. It turned out that the sleigh clock, which showed Santa how much time he had left until he reached the next child to whom he should leave a gift, had broken. Instead of showing the time as a combination of years, days, hours, minutes and seconds, the clock only shows the number of seconds remaining. Santa's team needs your help again. Knowing that a year has 365 days and a day has 24 hours, define the **formatDuration :: Int -> String** function, which takes a time represented as the number of seconds and returns the time in the described combination. If n is zero, return "now".

```haskell
formatDuration 0    -- ➝ "now"
formatDuration 1    -- ➝ "1 second"
formatDuration 62   -- ➝ "1 minute and 2 seconds"
formatDuration 120  -- ➝ "2 minutes"
formatDuration 3600 -- ➝ "1 hour"
formatDuration 3662 -- ➝ "1 hour, 1 minute and 2 seconds"
```

### Homework 4

#### Task 1

Let the following database structure be defined:

```haskell
type Name = String
type Date = String
type Class = String
type Result = String
type Launched = Int

data Battle = Battle Name Date deriving Show
data Ship = Ship Name Class Launched deriving Show
data Outcome = Outcome Name Name Result deriving Show

type Database = ([Outcome], [Battle], [Ship])
```

The algebraic type of **Battle** represents the data for a battle - its name and the date on which it took place. The algebraic type **Ship** represents the data for a ship - its name and the year of its launch. The algebraic type **Outcome** presents the result data for a ship from a battle - ship name, battle name and ship result - whether it was damaged, sunk or undamaged (ok).

Define the following functions:

- function **getSunk :: Database -> [(Name, [Name])]**, which receives as an argument a database and returns the names of all ships sunk in battle, in the form of a list of pairs of the type **(< battle name> , (list of names of ships sunk in this battle>)**

- function **inBattleAfterDamaged :: Database -> [Name]**, which receives as an argument a database and returns a list of the names of those ships that were damaged in one battle, but later participated in another battle.

#### Task 2

Let an algebraic type with the following definition be used to represent a binary tree of integers:

```haskell
data BTree = Nil | Node Int BTree Btree
```

Define the **grandchildrenIncreased :: BTree -> Bool** function, which checks to see if each vertex of a binary tree is bigger than its grandfather (if any).
