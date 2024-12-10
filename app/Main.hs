module Main where

import ReadFile
import TokenizeText
import Tree


main :: IO ()
main = do
    let path = "war_and_peace.txt"

    -- Read the text file
    text <- readContent path

    -- TODO: cut out everything that is not the actual text

    -- Tokenize the text file
    let tokenized = tokenize text

    -- Insert each unique word into the red-black tree
    let tree = createTree tokenized

    -- Traverse tree to get the sorted list of words
    let list = traverseTree tree

    -- TODO: Write the sorted list to "output.txt"
    