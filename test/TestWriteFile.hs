module TestWriteFile (writeToFileTest) where

import WriteFile
import Test.HUnit

writeToFileTest :: Test
writeToFileTest = TestCase $ do
    let list = ["one", "two", "some-thing", "words'"]
    writeToFile "test/output-test.txt" list

    recieved <- readFile "test/output-test.txt"
    let expected = "one\ntwo\nsome-thing\nwords'\n"
    
    assertEqual "Write file and read it again" expected recieved