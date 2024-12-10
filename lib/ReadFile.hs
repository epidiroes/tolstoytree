module ReadFile (readFileContent) where

readFileContent :: FilePath -> IO String
readFileContent path = do
    content <- readFile path
    return content