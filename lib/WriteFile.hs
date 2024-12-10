module WriteFile (writeToFile) where

writeToFile :: FilePath -> [String] -> IO ()
writeToFile path list = writeFile path (unlines list)
