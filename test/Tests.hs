module Main (main) where

import Test.HUnit
import qualified TestTree
import qualified TestReadFile
import qualified TestTokenizeText
import qualified TestWriteFile
import qualified System.Exit as Exit


tests :: Test
tests = TestList [TestTree.testInsert, 
                TestTree.testCreateTree, 
                TestTree.testTraverseTree, 
                TestReadFile.readFileTest,
                TestTokenizeText.tokenizeTextTest,
                TestTokenizeText.splitOnPrefaceTest,
                TestTokenizeText.splitOnAppendixTest,
                TestTokenizeText.linesTEst,
                TestWriteFile.writeToFileTest]


main :: IO ()
main = do
    result <- runTestTT tests
    if failures result > 0 then Exit.exitFailure else Exit.exitSuccess
