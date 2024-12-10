module TestTree (testInsert, testCreateTree, testTraverseTree) where

import Tree
import Test.HUnit

testInsert :: Test
testInsert = TestCase $ do
    let tree = insert "banana" E
    let tree2 = insert "apple" tree
    let tree3 = insert "cherry" tree2
    assertEqual "Insert apple into tree" (traverseTree tree2) ["apple", "banana"]
    assertEqual "Insert cherry into tree" (traverseTree tree3) ["apple", "banana", "cherry"]

testCreateTree :: Test
testCreateTree = TestCase $ do
    let tree = createTree ["banana", "apple", "cherry"]
    assertEqual "Create tree from list" (traverseTree tree) ["apple", "banana", "cherry"]

testTraverseTree :: Test
testTraverseTree = TestCase $ do
    let tree = createTree ["banana", "apple", "cherry"]
    assertEqual "Traverse tree" (traverseTree tree) ["apple", "banana", "cherry"]