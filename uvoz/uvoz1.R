source("lib/libraries.r")
library(curl)
# Uvezemo podatke za porabo, izvoz in uvoz.


# Sestavimo glavno tabelo v obliki tidy, ki vsebuje vse glavne podatke. Pozneje jo bomo razdelili na "pod tabele".
all_products <- read.csv("podatki/nrg_110a/nrg_110a_1_Data.csv",
                         header = TRUE ,
                         dec=".",
                         na=c(":"))
all_products$Value <- gsub(" ", "", all_products$Value);
all_products$GEO <- gsub(" \\(until 1990 former territory of the FRG\\)","",all_products$GEO)
all_products$GEO <- factor(all_products$GEO)
all_products$Value <- parse_integer(all_products$Value);
Leta <- c("2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015");
all_products$TIME <- parse_factor(all_products$TIME,Leta);
all_products$UNIT <- NULL

write.csv(all_products,"podatki/all_products.csv")

#Uvezemo populacijo evropskih držav

uvozi.pop <- function() {
  link <- "https://en.wikipedia.org/wiki/Demographics_of_Europe"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec = ",")
  colnames(tabela) <- c("Država","Površina","Populacija","Gostota","Prestolnica")
  for (col in c("Površina","Gostota","Prestolnica")) {tabela[[col]] <- NULL}
  tabela$Populacija <- gsub(",","",tabela$Populacija)
  tabela$Populacija <- parse_integer(tabela$Populacija)

  return(tabela)
}

po <- uvozi.pop()
d <- levels(all_products$GEO)!=c("Euro area (19 countries)","European Union (28 countries)")
drzave <- levels(all_products$GEO)[d]

po <- filter(po,po$Država %in% drzave)
po$Država <- parse_factor(po$Država,levels(all_products$GEO))

write_csv(po,"podatki/populacija.csv")

uvoz.ak <- function(){
  link <- "https://en.wikipedia.org/wiki/ISO_3166-2"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec = ",")
  colnames(tabela) <- c("Koda","Država","n")
  tabela$n <- NULL
  tabela$Država <- gsub("\\[note 1\\]","",tabela$Država)
  tabela$Država <- parse_factor(tabela$Država,tabela$Država)
  tabela <- filter(tabela, tabela$Država %in% drzave)
  
  return(tabela)
}
ak <- uvoz.ak()
