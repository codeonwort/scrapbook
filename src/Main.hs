module Main where
import Config

import Data.Maybe
import Haste
import Haste.DOM
import Haste.Ajax
import Haste.Events

main = withElems ["url_txt", "info_txt", "submit_btn", "list"] $ \[url, info, submit, links] -> do
	onEvent submit Click $ \_ -> do
		url_value <- fromJust `fmap` getValue url :: IO String
		info_value <- fromJust `fmap` getValue info :: IO String
		upload url_value info_value links
	ajaxRequest GET downloader noParams (update links)

upload url_value info_value links = do
	let link = [(toJSString "url", toJSString url_value), (toJSString "info", toJSString info_value)]
	ajaxRequest GET uploader link (uploadEnd links)

uploadEnd :: Elem -> Maybe String -> IO ()
uploadEnd links res = do
	ajaxRequest GET downloader noParams (update links)

update :: Elem -> Maybe String -> IO ()
update links respond = do
	setProp links "innerHTML" (items $ lines (fromJust respond))

items [] = ""
items (url:info:xs) = "<li><a href=" ++ url ++ ">" ++ (tip info url) ++ "</a></li>" ++ (items xs)
tip info url = "<div title=" ++ url ++ ">" ++ info ++ "</div>"
