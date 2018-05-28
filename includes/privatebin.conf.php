;<?php http_response_code(403);

[main]
name = "PrivateBin"
discussion = true
opendiscussion = false
password = true
fileupload = true
burnafterreadingselected = false
defaultformatter = "plaintext"
sizelimit = 2097152
template = "bootstrap"
languageselection = false
; urlshortener = "https://shortener.example.com/api?link="
qrcode = true
zerobincompatibility = false

[expire]
default = "1week"

[expire_options]
5min = 300
10min = 600
1hour = 3600
1day = 86400
1week = 604800
1month = 2592000
1year = 31536000
never = 0

[formatter_options]
plaintext = "Plain Text"
syntaxhighlighting = "Source Code"
markdown = "Markdown"

[traffic]
limit = 5
dir = PATH "/privatebin-data"

[purge]
limit = 300
batchsize = 10
dir = PATH "/privatebin-data"