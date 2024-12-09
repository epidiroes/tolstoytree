module Tree (Tree(..), insert, createTree, traverseTree) where

-- red or black
data Color = R | B deriving Show

-- E for empty and N for node
data Tree a = E | N Color (Tree a) a (Tree a) deriving Show

insert :: (Ord a) => a -> Tree a -> Tree a
insert x t = createNode $ ins t
    where 
        ins E = N R E x E
        ins (N color a y b)
            | x < y = balance color (ins a) y b
            | x == y = N color a y b                -- return the tree if the element exists
            | x > y = balance color a y (ins b)
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