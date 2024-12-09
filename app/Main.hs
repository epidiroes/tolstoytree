module Main where

import Tree

main :: IO ()
main = do
    -- Ein Beispiel für das Erstellen eines Baums aus einer Liste von Strings
    let inputList = ["apple", "orange", "banana", "grape", "pear"]
    let tree = createTree inputList

    -- Den Baum in Inorder-Traversierung ausgeben (d.h. sortierte Ausgabe)
    putStrLn "Inorder Traversal of the Tree:"
    print (traverseTree tree)


