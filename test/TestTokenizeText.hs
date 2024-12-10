module TestTokenizeText (tokenizeTextTest) where

import TokenizeText
import Test.HUnit

tokenizeTextTest :: Test
tokenizeTextTest = TestCase $ do
    let text = "\"The execution of the Duc d'Enghien,\"; \"What, Monsieur Pierre...; Won't you;\n\
                \that was good in it--equality of citizenship; one man's life.; thing?... Well, after that...\n\
                \But won't; high-sounding words; a duc--or even an ordinary man who--is\n\
                \innocent; She said, 'Girl,' to the maid; the little princess' sister-in-law."
    let expected = ["the", "execution", "of", "the", "duc", "d'enghien", "what", "monsieur", "pierre", "won't", "you", 
                    "that", "was", "good", "in", "it", "equality", "of", "citizenship", "one", "man", "life", "thing", "well", "after", "that",
                    "but", "won't", "high-sounding", "words", "a", "duc", "or", "even", "an", "ordinary", "man", "who", "is",
                    "innocent", "she", "said", "girl", "to", "the", "maid", "the", "little", "princess", "sister-in-law"]
    let recieved = TokenizeText.tokenize text
    assertEqual "Tokenize text" expected recieved
