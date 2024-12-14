module TokenizeText (tokenize, splitOnPreface, splitOnAppendix) where

import Data.Char (toLower, isAlpha)
import Data.List (words, isSuffixOf, isPrefixOf)
import Data.List.Split (splitOn)
-- import Control.Parallel.Strategies (parMap, rdeepseq)

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

-- has to be done first, because the dashes could be outside the apostrophes
removeOuterDashes :: String -> String
removeOuterDashes str
    | "-" `isPrefixOf` str && "-" `isSuffixOf` str = init (tail str)
    | "-" `isPrefixOf` str = tail str
    | "-" `isSuffixOf` str = init str
    | otherwise = str

splitOnPreface :: String -> String
splitOnPreface str = last (splitOn "*** START OF THE PROJECT GUTENBERG EBOOK, WAR AND PEACE ***" str)

splitOnAppendix :: String -> String
splitOnAppendix str = head (splitOn "*** END OF THE PROJECT GUTENBERG EBOOK, WAR AND PEACE ***" str)

tokenize :: String -> [String]
tokenize str = map (removeTrailingS . removeOuterApostrophes . removeOuterDashes) $ filter validToken $ concatMap splitOnDash $ words $ map toLower $ filter isValidChar $ splitOnAppendix $ splitOnPreface str
    where
        isValidChar c = isAlpha c || c == '\'' || c == '\n' || c == '-' || c == ' '
        splitOnDash word = splitOn "--" word
        validToken token = token /= "-" && token /= "'"