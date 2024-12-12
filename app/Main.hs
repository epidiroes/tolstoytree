module Main where

import WriteFile
import ReadFile
import TokenizeText
import Tree


main :: IO ()
main = do
    let inputPath = "war_and_peace.txt"
    let outputPath = "output.txt"

    -- TODO: Measure the performance speed before and after parallization

    -- Read the text file
    text <- readContent inputPath

    -- TODO: parallelize the tokenization
    -- Tokenize the text file
    let tokenized = tokenize text

    -- TODO: parallelize the insertion into the tree
    -- Insert each unique word into the red-black tree
    let tree = createTree tokenized

    -- Traverse tree to get the sorted list of words
    let list = traverseTree tree

    -- Write the sorted list to "output.txt"
    writeToFile outputPath list
    