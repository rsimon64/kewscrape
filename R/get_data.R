library(xml2)
library(rvest)
library(stringr)

site <- "http://data.kew.org/sid/"

url <- "C:/Users/rsimon/Documents/projects/flor/"

# join all kew files into one
kew_list <- list.files(url, pattern = "kew-*.*", full.names = TRUE)
kew_file <- file.path(url, "kew-all.txt")
for(i in seq_along(kew_list)) {
  txt <- readLines(kew_list[i])
  write(txt, kew_file, append = TRUE )
}


pg <- read_html(kew_file)
tx <- readLines(kew_file)

tx <- str_replace_all(tx, "`", "")

behavior <- str_extract_all(tx, "(</A><B>)(.*?)(?=</B>)") %>% str_replace_all("</A><B> ", "")
behavior <- behavior[behavior %in% c("Intermediate", "Intermediate?", "Orthodox", "Orthodox p", "Orthodox?",
                                     "Recalcitrant", "Recalcitrant?", "Uncertain")]


links <- paste0(site, html_attr(html_nodes(pg, "a"), "href"))
labels <-pg %>% html_nodes("a") %>% html_text()

seeds <- tibble::tibble(links = links, labels = labels, behavior = behavior)
seeds <- dplyr::arrange(seeds, labels)

names(seeds) <- c("url", "species", "storage")

saveRDS(seeds, file="seeds.rds")

