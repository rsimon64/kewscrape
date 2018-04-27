seeds <- readRDS("seeds.rds")

seeds$species <- paste0("<a href='",seeds$url,"' target='_blank'>", seeds$species,"</a>")
items <- paste0(seeds$species, "&nbsp;<b>", seeds$storage, "</b><br/>" )

header <- "<html><head><title>Kew Seeds Database</title>
<style>
body {
  font-family: 'Verdana', Verdana, sans-serif;

  margin-top: 10px;
  margin-bottom: 10px;
  margin-left: 70px;
}
</style>

</head><body><h2>Kew Seeds Database</h2><p>"
footer <- "</p></body></html>"

dest <- "seeds.html"

write(header, file = dest)
write(items, file = dest, append = TRUE)
write(footer, file = dest, append = TRUE)
