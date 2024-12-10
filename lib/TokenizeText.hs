module TokenizeText (tokenize) where

import Data.Char (toLower, isAlpha)
import Data.List (words, isSuffixOf, isPrefixOf)
import Data.List.Split (splitOn)

removeOuterApostrophes :: String -> String
removeOuterApostrophes str
    | "'" `isPrefixOf` str && "'" `isSuffixOf` str = init (tail str)
    | otherwise = str

tokenize :: String -> [String]
tokenize str = map removeOuterApostrophes $ concatMap splitOnDash $ words $ map toLower $ filter isValidChar str
    where
        isValidChar c = isAlpha c || c == '\'' || c == '\n' || c == '-' || c == ' '
        splitOnDash word = splitOn "--" word