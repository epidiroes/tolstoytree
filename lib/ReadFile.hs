module ReadFile (readContent) where

readContent :: FilePath -> IO String
readContent path = do
    content <- readFile path
    return content