# scrapbook

- Language : Haste (http://haste-lang.org/)

- Service  : Scrap all URLs of my interest

- Details  : A wep page that displays collected URLs and has a form to add new URL.

### How to build and setup on your server
1. You need Haste and MySQL.
2. Select where to launch your application. ex) www.example.com/scrap
3. In src/Config.hs, edit following lines, for example:
  - downloader = "www.example.com/scrap/download.php"
  - uploader = "www.example.com/scrap/uploader.php"
  - remover = "www.example.com/scrap/remover.php"
4. Create a table of following schema into any MySQL database:

    ```
    CREATE TABLE `scrapbook` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `url` varchar(127) NOT NULL,
    `info` varchar(127) DEFAULT NULL,
    PRIMARY KEY (`id`)
    )
	```

5. In src/config.php, enter your mysql id, pwd, and database name.
6. Run the command: `haste-cabal build`. You get Main.js in the folder src.
7. Move following files to www.example.com/scrap/.
  - index.html
  - style.css
  - Main.js
  - download.php
  - uploader.php
