module Main where
import Config (uploader, downloader, remover)

import Data.Maybe
import Control.Monad

import Haste
import Haste.DOM
import Haste.Ajax
import Haste.Events

-- id of DOM elements
id_elements = ["url_txt", "info_txt", "submit_btn", "list"]

main = withElems id_elements $ \[url, info, submit, links] -> do
	-- event listener for 'submit_btn'
	-- add a new url to the url list
	onEvent submit Click $ \_ -> do
		url_value <- fromJust `fmap` getValue url :: IO String
		info_value <- fromJust `fmap` getValue info :: IO String
		upload url_value info_value links
	ajaxRequest GET downloader noParams (update links)

-- upload a new url to the server
upload url_value info_value links = do
	let link = [(toJSString "url", toJSString url_value), (toJSString "info", toJSString info_value)]
	ajaxRequest GET uploader link (uploadEnd links)

-- event: when finished uploading
uploadEnd :: Elem -> Maybe String -> IO ()
uploadEnd links res = do
	ajaxRequest GET downloader noParams (update links)

-- update the url list view
update :: Elem -> Maybe String -> IO ()
update links respond = do
	setProp links "innerHTML" (items $ lines (fromJust respond))
	deleteBtns <- elemsByQS links ".material-icons"
	forM_ deleteBtns $ \btn -> do
		onEvent btn Click $ \_ -> do
			row_id <- getAttr btn "row_id"
			remove row_id links

-- remove a record from current list
remove :: String -> Elem -> IO ()
remove row_id links = do
	let row = [(toJSString "row", toJSString row_id)]
	ajaxRequest GET remover row postupdate where
		postupdate :: Maybe String -> IO ()
		postupdate _ = ajaxRequest GET downloader noParams (update links)

-- urls and there descriptions are downloaded as a string separated by newlines.
items :: [String] -> String
items [] = ""
items (row_id:url:info:xs) = concat
	[deleteBtn row_id, "<li><a href=", url, ">",
	tip info url, "</a></li>",
	br, items xs]

-- helper for the function items
tip info url = concat ["<span class=info_box title=", url, ">", info, "</span>"]
deleteBtn row_id = concat ["<i row_id=", row_id, " class=material-icons>delete_forever</i>"]
br = "<br/>"
