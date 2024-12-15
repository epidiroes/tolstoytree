module TokenizeText (tokenize, tokenized, splitOnPreface, splitOnAppendix) where

import Data.Char (toLower, isAlpha)
import Data.List (words, isSuffixOf, isPrefixOf)
import Data.List.Split (splitOn)
import Control.Parallel.Strategies (parMap, rdeepseq)

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

tokenized :: String -> [String]
tokenized str = map (removeTrailingS . removeOuterApostrophes . removeOuterDashes) $ concatMap (filter validToken . splitOnDash) (words $ map toLower $ filter isValidChar $ splitOnAppendix $ splitOnPreface str)
    where
        isValidChar c = isAlpha c || c == '\'' || c == '\n' || c == '-' || c == ' '
        validToken token = token /= "-" && token /= "'"
        splitOnDash = splitOn "--"


-- Divides text into its lines to tokenize every line parallel -> Parallelization
tokenize :: String -> [String]
tokenize text =
  let line = lines text
      -- Hier alle Zeilen tokenisieren und bereinigen:
      tokenizedLines = parMap rdeepseq tokenized line
  in concatMap (filter (not . null)) tokenizedLines
