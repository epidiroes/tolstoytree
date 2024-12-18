--{-# LANGUAGE FlexibleInstances #-} -- for createTreeParallel to work in theory

module Tree (Tree(..), insert, createTree, traverseTree) where
--module Tree (Tree(..), insert, createTree, traverseTree, traverseTreeParallel) where
--module Tree (Tree(..), insert, createTree, createTreeParallel, traverseTree) where
--import Control.Parallel.Strategies (parMap, rdeepseq, parList, using, rpar, rseq)
--import Control.DeepSeq (NFData(..))
--import Control.Parallel (par, pseq)

-- red or black
data Color = R | B deriving Show

-- E for empty and N for node
data Tree a = E | N Color (Tree a) a (Tree a) deriving Show

{-
-- for createTreeParallel to work in thoery
instance NFData (Tree String) where
    rnf E = ()
    rnf (N _ left val right) = rnf left `seq` rnf val `seq` rnf right
-}

-- Non parallel insert
-- cabal run tolstoytree-exe -- +RTS -s
insert :: (Ord a) => a -> Tree a -> Tree a
insert x t = createNode $ ins t
    where 
        ins E = N R E x E
        ins (N color a y b)
            | x < y = balance color (ins a) y b
            | x == y = N color a y b                -- return the tree if the already element exists
            | x > y = balance color a y (ins b)
        createNode (N _ a y b) = N B a y b

{-
-- Parallel insert
-- cabal run tolstoytree-exe -- +RTS -N -s
insert :: (Ord a) => a -> Tree a -> Tree a
insert x t = createNode $ ins t
  where
    ins E = N R E x E
    ins (N color a y b)
        | x < y =
            let newLeft = ins a
            in newLeft `par` (balance color newLeft y b `pseq` balance color newLeft y b)
        | x > y =
            let newRight = ins b
            in newRight `par` (balance color a y newRight `pseq` balance color a y newRight)
        | otherwise = N color a y b -- Element already exists, return the same tree.

    createNode (N _ a y b) = N B a y b
-}
 
balance :: Color -> Tree a -> a -> Tree a -> Tree a
balance B (N R (N R a x b) y c) z d = N R (N B a x b) y (N B c z d)
balance B (N R a x (N R b y c)) z d = N R (N B a x b) y (N B c z d)
balance B a x (N R (N R b y c) z d) = N R (N B a x b) y (N B c z d)
balance B a x (N R b y (N R c z d)) = N R (N B a x b) y (N B c z d)
balance color a x b = N color a x b

createTree :: [String] -> Tree String
createTree = foldr insert E

-- Non parallel traverse
traverseTree :: Tree a -> [a]
traverseTree E = []
traverseTree (N _ a x b) = traverseTree a ++ [x] ++ traverseTree b

{-
-- Funltioniert, aber ist nicht merkbar schneller oder langsamer
-- Parallel traverse
traverseTreeParallel :: Tree a -> [a]
traverseTreeParallel E = []
traverseTreeParallel (N _ a x b) =
  left `par` (right `pseq` (left ++ [x] ++ right))
  where
    left = traverseTreeParallel a
    right = traverseTreeParallel b
-}

{-
-- TERMINIERT NICHT aaahhh
-- Kombinieren von zwei Bäumen
mergeTrees :: Tree String -> Tree String -> Tree String
mergeTrees t1 t2 = foldr insert t1 (traverseTree t2)

-- Parallele Version von createTree
createTreeParallel :: [String] -> Tree String
createTreeParallel str = foldr mergeTrees E partialTrees
  where
    chunkedString = chunks 4 str
    partialTrees = parMap rdeepseq createTree chunkedString

-- Zerlegen einer Liste in gleich große Teile
chunks :: Int -> [a] -> [[a]]
chunks _ [] = []
chunks n xs = take n xs : chunks n (drop n xs)
-}