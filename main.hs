import System.IO  
import System.Environment   
import Data.List
import Network.Curl.Download
import qualified Data.ByteString as S  
import qualified Data.Either as E

getFileNameFromArgs :: [String] -> String
getFileNameFromArgs args = head args

getOutputPath :: FilePath -> FilePath -> FilePath
getOutputPath fileName imgName = "./imgs/"++ fileName ++ "/"++ imgName


main = do  
    args <- getArgs  
    let fileName = getFileNameFromArgs args
    putStrLn ("File name is : " ++ fileName)

    contents <- readFile ("./data/"++fileName)
    let urls = lines contents
        imgs = drop 5 urls
    
    mapM (\i -> do
        let imgName = drop 102 i
            newName = getOutputPath fileName imgName
        putStrLn i
        doc  <- openURI i
        E.either (\e -> putStrLn ("err: "++i++" - "++ e)) (\x -> S.writeFile newName x) doc
        ) imgs

    putStrLn "Done!!!"
