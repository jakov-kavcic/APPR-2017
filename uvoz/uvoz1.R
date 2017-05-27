# Uvezemo podatke za porabo, izvoz in uvoz.


# Sestavimo glavno tabelo v obliki tidy, ki vsebuje vse glavne podatke. Pozneje jo bomo razdelili na "pod tabele".
all_products <- read.csv("podatki/nrg_110a/nrg_110a_1_Data.csv",
                         header = TRUE ,
                         dec=".",
                         na=c(":"))
all_products$Value <- gsub(" ", "", all_products$Value);
all_products$GEO <- gsub(" \\(until 1990 former territory of the FRG\\)","",all_products$GEO)
all_products$GEO <- gsub("Former Yugoslav Republic of Macedonia, the","Macedonia",all_products$GEO)
all_products$GEO <- factor(all_products$GEO)
all_products$Value <- parse_integer(all_products$Value);
Leta <- c("2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015");
all_products$TIME <- as.numeric(all_products$TIME);
all_products$UNIT <- NULL

write.csv(all_products,"podatki/all_products.csv")

drzave <- levels(all_products$GEO)

#Uvezemo populacijo evropskih držav

uvozi.pop <- function() {
  link <- "https://en.wikipedia.org/wiki/Demographics_of_Europe"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec = ",")
  colnames(tabela) <- c("GEO","Površina","Populacija","Gostota","Prestolnica")
  for (col in c("Površina","Gostota","Prestolnica")) {tabela[[col]] <- NULL}
 
  tabela$GEO <- gsub( "Cypruse\\[›\\]","Cyprus",tabela$GEO)
  tabela$GEO <- gsub("Portugalf\\[›\\]","Portugal",tabela$GEO)
  tabela$GEO <- gsub("Serbiag\\[›\\]","Serbia",tabela$GEO)
  tabela$GEO <- gsub("\\[›\\]","",tabela$GEO)
  tabela$Populacija <- gsub(",","",tabela$Populacija)
  tabela$Populacija <- parse_integer(tabela$Populacija)

  return(tabela)
}

po <- uvozi.pop()

po <- filter(po,po$GEO %in% drzave)
po$GEO <- parse_factor(po$GEO,drzave)

write_csv(po,"podatki/populacija.csv")

uvoz.ak <- function(){
  link <- "https://en.wikipedia.org/wiki/ISO_3166-2"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec = ",")
  colnames(tabela) <- c("Koda","GEO","n")
  tabela$n <- NULL
  tabela$GEO <- gsub("\\[note 1\\]","",tabela$GEO)
  tabela$GEO <- gsub("Czechia","Czech Republic",tabela$GEO)
  tabela$GEO <- gsub("^.*Macedonia.*$", "Macedonia", tabela$GEO)
  tabela$Koda <- gsub("GB","UK",tabela$Koda)
  tabela$Koda <- gsub("GR","EL",tabela$Koda)
  tabela <- filter(tabela, tabela$GEO %in% drzave)
  tabela$GEO <- parse_factor(tabela$GEO,tabela$GEO)
  tabela <- tabela[,c("GEO","Koda")]
  return(tabela)
}
ak <- uvoz.ak()

write_csv(ak,"podatki/kode.csv")
