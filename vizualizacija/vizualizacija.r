

# 3. faza: Vizualizacija podatkov
dir <- ".."
# Uvozimo zemljevid.
zemljevid <- uvozi.zemljevid("http://ec.europa.eu/eurostat/cache/GISCO/geodatafiles/NUTS_2013_01M_SH.zip",
                             "NUTS_2013_01M_SH/data/NUTS_RG_01M_2013", encoding = "Windows-1250") %>%
  pretvori.zemljevid() %>% filter(STAT_LEVL_ ==0)

#Napišemo tabelo za vizualizacijo

poraba_po <- all_products %>% filter(PRODUCT=="All products" & 
                                       INDIC_NRG=="Gross inland consumption" &
                                       TIME=="2015" &
                                       GEO %in% drzave) %>%
  select(GEO, Poraba = Value) %>% inner_join(po) %>% transmute(GEO = parse_factor(GEO, ak$GEO),na.prebivalca = Poraba / Populacija) %>% 
  inner_join(ak)%>% mutate(Koda = factor(Koda, levels = levels(zemljevid$NUTS_ID)))
poraba_po <- filter(poraba_po,poraba_po$Koda !="IS")
poraba_po <- poraba_po[,c("GEO","Koda","na.prebivalca")]
