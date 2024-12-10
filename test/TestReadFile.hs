module TestReadFile (readFileTest) where

import ReadFile
import Test.HUnit

readFileTest :: Test
readFileTest = TestCase $ do
    recieved <- readContent "test/testfile.txt"
    let expected = "This is a test file.\n\
            \For tesing the functions. I don't know how it will handle this.\n\
            \Isn't it neat? How will it handle brok-\n\
            \en up words?\n\
            \\"And those things, can't forget about them!\", she said.\n\
            \NO, wHy WoN't iT wOrK."

    assertEqual "Read file" expected recieved