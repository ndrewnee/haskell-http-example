{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.ByteString               as BS
import           Network.Wai                    ( Application
                                                , responseLBS
                                                , requestMethod
                                                , rawPathInfo
                                                )
import           Network.HTTP.Types             ( status200
                                                , status404
                                                , status405
                                                , hContentType
                                                , hContentLength
                                                , methodGet
                                                )
import           Network.Wai.Handler.Warp       ( run )
import           Data.ByteString.Lazy.UTF8      ( fromString )
import           Lib                            ( archsJSON
                                                , catalogsJSON
                                                )
import           Options.Applicative
import           Data.Semigroup                 ( (<>) )

newtype Config = Config
    { port :: Int }

config :: Parser Config
config = Config <$> option
    auto
    (  long "port"
    <> short 'p'
    <> help "HTTP Web Server port"
    <> showDefault
    <> value 37011
    <> metavar "INT"
    )

application :: Application
application req respond
    | requestMethod req /= methodGet = respond $ responseLBS status405 [] ""
    | path == "assets/schemas/archs" = respond $ responseLBS
        status200
        [(hContentType, "application/json")]
        (fromString archsJSON)
    | path == "assets/deviceCatalog" = respond $ responseLBS
        status200
        [(hContentType, "application/json")]
        (fromString catalogsJSON)
    | otherwise = respond $ responseLBS status404 [] ""
    where path = BS.tail $ rawPathInfo req

main :: IO ()
main = runApp =<< execParser opts
  where
    opts = info
        (config <**> helper)
        (fullDesc <> progDesc "Simple http server for mocking assets" <> header
            "haskell-http-example - tool to mock assets"
        )

runApp :: Config -> IO ()
runApp (Config port) = do
    putStrLn $ "Listening on address :" ++ show port
    run port application
