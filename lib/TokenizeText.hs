module TokenizeText (tokenize) where

import Data.Char (toLower, isAlpha)
import Data.List (words, isSuffixOf, isPrefixOf)
import Data.List.Split (splitOn)

removeTrailingS :: String -> String
removeTrailingS str
    | "'s" `isSuffixOf` str = init (init str)
    | otherwise = str

removeOuterApostrophes :: String -> String
removeOuterApostrophes str
    | "'" `isPrefixOf` str && "'" `isSuffixOf` str = init (tail str)
    | "'" `isPrefixOf` str = tail str
    | "'" `isSuffixOf` str = init str
    | otherwise = str

removeOuterDashes :: String -> String
removeOuterDashes str
    | "-" `isPrefixOf` str && "-" `isSuffixOf` str = init (tail str)
    | "-" `isPrefixOf` str = tail str
    | "-" `isSuffixOf` str = init str
    | otherwise = str

tokenize :: String -> [String]
tokenize str = map (removeTrailingS . removeOuterApostrophes . removeOuterDashes) $ filter validToken $ concatMap splitOnDash $ words $ map toLower $ filter isValidChar str
    where
        isValidChar c = isAlpha c || c == '\'' || c == '\n' || c == '-' || c == ' '
        splitOnDash word = splitOn "--" word
        validToken token = token /= "-" && token /= "'"