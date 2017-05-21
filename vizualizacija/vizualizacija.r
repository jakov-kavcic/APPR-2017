source("lib/libraries.r")
library("RColorBrewer")
library("classInt")
# 3. faza: Vizualizacija podatkov
dir <- ".."
# Uvozimo zemljevid.
zemljevid <- uvozi.zemljevid("http://ec.europa.eu/eurostat/cache/GISCO/geodatafiles/NUTS_2013_01M_SH.zip",
                             "NUTS_2013_01M_SH/data/NUTS_RG_01M_2013", encoding = "Windows-1250")
zemljevid <- zemljevid[zemljevid$STAT_LEVL_==0,]

# levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
#   { gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
# zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels = levels(obcine$obcina))
#zemljevid <- pretvori.zemljevid(zemljevid)


#Napišemo tabelo za vizualizacijo

poraba_po <- all_products %>% filter(all_products$PRODUCT=="All products" & 
                                       all_products$INDIC_NRG=="Gross inland consumption" &
                                       all_products$TIME=="2015" &
                                       all_products$GEO %in% drzave)
poraba_po$TIME <- NULL
poraba_po$PRODUCT <- NULL
poraba_po$INDIC_NRG <- NULL
colnames(poraba_po)[2] <- "Poraba"
poraba_po <- merge(poraba_po,po,by.x="GEO",by.y="Država")
poraba_po <- add_column(poraba_po,poraba_po$Poraba/poraba_po$Populacija)
colnames(poraba_po) <- c("Država","Poraba","Populacija","Na prebivalca")
poraba_po$Država <- parse_factor(poraba_po$Država,poraba_po$Država)
poraba_po <- merge(poraba_po,ak,by.x="Država")


zemljevid <- SpatialPolygonsDataFrame(zemljevid,data= data.frame(zemljevid, poraba_po[match(zemljevid$NUTS_ID, poraba_po$Koda),]))
num.int <- 6
pal = brewer.pal(num.int,"Blues")
agg.pp <- aggregate(zemljevid$Na.prebivalca, by=list(zemljevid$NUTS_ID), FUN=mean)
brks.qt = classIntervals(agg.pp$x, n = num.int, style = "quantile")
brks.jk = classIntervals(agg.pp$x, n = num.int, style = "jenks")
brks.eq = classIntervals(agg.pp$x, n = num.int, style = "equal")
brks.pr = classIntervals(agg.pp$x, n = num.int, style = "pretty")

plot <- spplot(zemljevid, c("Na.prebivalca"), names.attr =c("Na.prebivalca"),
             at= brks.pr$brks,
             col=grey(.9), col.regions=pal,
             main="Poraba na prebivalca",
             xlim = c(-12, 42), ylim = c(33, 72),
             par.settings = list(axis.line = list(col =  'transparent')))


png(filename = "vizualizacija/Na_prebivalca.png",units = "px", width=800, height=600)
plot
dev.off()
