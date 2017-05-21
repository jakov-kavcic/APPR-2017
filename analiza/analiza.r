
source("lib/libraries.r")
source("uvoz/uvoz1.R")
# # 4. faza: Analiza podatkov
# 
# podatki <- obcine %>% transmute(obcina, povrsina, gostota,
#                                 gostota.naselij = naselja/povrsina) %>%
#   left_join(povprecja, by = "obcina")
# row.names(podatki) <- podatki$obcina
# podatki$obcina <- NULL
# 
# # Število skupin
# n <- 5
# skupine <- hclust(dist(scale(podatki))) %>% cutree(n)

#Razlika med Porabo in uvozom. Torej Koliko je bilo ustvarjene energije oz. potrošene iz zaloge.

proizvodnja <- spread(all_products, INDIC_NRG, Value)
proizvodnja <- add_column(proizvodnja,proizvodnja$'Gross inland consumption' - proizvodnja$Imports)
colnames(proizvodnja)[7] <- "Proizvodnja/zaloga"
proizvodnja$Imports <- NULL
proizvodnja$Exports <- NULL
proizvodnja$`Gross inland consumption` <- NULL

write.csv(proizvodnja,"podatki/prouizvodnja.csv")

#Razlika med uvozom in izvozom

neto <- spread(all_products, INDIC_NRG, Value)
neto <- add_column(neto,-neto$Imports + neto$Exports)
colnames(neto)[7] = "Neto" 
neto$Imports <- NULL
neto$Exports <- NULL
neto$`Gross inland consumption` <- NULL


write.csv(neto,"podatki/neto.csv")

#Rast porabe po GEO






