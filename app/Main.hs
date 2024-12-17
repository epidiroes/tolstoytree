module Main where

import WriteFile
import ReadFile
import TokenizeText
import Tree


main :: IO ()
main = do
    let inputPath = "war_and_peace.txt"
    let outputPath = "output.txt"

    -- Read the text file
    text <- readContent inputPath

    -- Tokenize the text file
    let tokenized = tokenize text

    -- Insert each unique word into the red-black tree
    let tree = createTree tokenized
    --let tree = createTreeParallel tokenized
    
    -- Traverse tree to get the sorted list of words
    let list = traverseTree tree

    -- The parallalized version, is just as fast tho
    --let list = traverseTreeParallel tree

    -- Write the sorted list to "output.txt"
    writeToFile outputPath list
    