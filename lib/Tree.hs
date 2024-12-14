module Tree (Tree(..), insert, createTree, traverseTree) where

import Control.Parallel (par, pseq)

-- red or black
data Color = R | B deriving Show

-- E for empty and N for node
data Tree a = E | N Color (Tree a) a (Tree a) deriving Show


{-
-- Non parallel insert
insert :: (Ord a) => a -> Tree a -> Tree a
insert x t = createNode $ ins t
    where 
        ins E = N R E x E
        ins (N color a y b)
            | x < y = balance color (ins a) y b
            | x == y = N color a y b                -- return the tree if the already element exists
            | x > y = balance color a y (ins b)
        createNode (N _ a y b) = N B a y b
 -}

-- Parallel insert
insert :: (Ord a) => a -> Tree a -> Tree a
insert x t = createNode $ ins t
  where
    ins E = N R E x E
    ins (N color a y b)
        | x < y =
            let newLeft = ins a
            in newLeft `par` balance color newLeft y b
        | x > y =
            let newRight = ins b
            in newRight `par` balance color a y newRight
        | otherwise = N color a y b -- Element already exists, return the same tree.

    createNode (N _ a y b) = N B a y b

balance :: Color -> Tree a -> a -> Tree a -> Tree a
balance B (N R (N R a x b) y c) z d = N R (N B a x b) y (N B c z d)
balance B (N R a x (N R b y c)) z d = N R (N B a x b) y (N B c z d)
balance B a x (N R (N R b y c) z d) = N R (N B a x b) y (N B c z d)
balance B a x (N R b y (N R c z d)) = N R (N B a x b) y (N B c z d)
balance color a x b = N color a x b

createTree :: [String] -> Tree String
createTree = foldr insert E

traverseTree :: Tree a -> [a]
traverseTree E = []
traverseTree (N _ a x b) = traverseTree a ++ [x] ++ traverseTree b