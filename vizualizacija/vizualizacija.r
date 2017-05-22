source("lib/libraries.r")


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
  select(GEO, Poraba = Value) %>% inner_join(po) %>% transmute(GEO = parse_factor(GEO, ak$GEO),
                                                               na.prebivalca = Poraba / Populacija) %>%
  inner_join(ak)
%>% mutate(Koda = factor(Koda, levels = levels(zemljevid$NUTS_ID)))


#zemljevid <- merge(zemljevid,poraba_po,by.x=c("NUTS_ID"), by.y=c("Koda"))

#Narišemo zemljevid

plot <- ggplot() + geom_polygon(data = zemljevid %>% left_join(poraba_po, by = c("NUTS_ID" = "Koda")),
                                aes(x = long, y = lat, group = group, fill = na.prebivalca)) +
        coord_map(xlim = c(-25, 45), ylim = c(32, 72))






#zemljevid <- SpatialPolygonsDataFrame(zemljevid,data= data.frame(zemljevid, poraba_po[match(zemljevid$NUTS_ID,
 #                                                                                           poraba_po$Koda),]))
# num.int <- 7
# pal = brewer.pal(num.int,"Greens")
# agg.pp <- aggregate(zemljevid$Na.prebivalca, by=list(zemljevid$NUTS_ID), FUN=mean)
# # brks.qt = classIntervals(agg.pp$x, n = num.int, style = "quantile")
# # brks.jk = classIntervals(agg.pp$x, n = num.int, style = "jenks")
# # brks.eq = classIntervals(agg.pp$x, n = num.int, style = "equal")
# brks.pr = classIntervals(agg.pp$x, n = num.int, style = "pretty")
# 
# plot <- spplot(zemljevid, c("Na.prebivalca"), names.attr =c("Na.prebivalca"),
#              at= brks.pr$brks,
#              col=grey(.9), col.regions=pal,
#              main="Poraba na prebivalca",
#              xlim = c(-12, 42), ylim = c(33, 72),
#              par.settings = list(axis.line = list(col =  'transparent')))


png(filename = "vizualizacija/Na_prebivalca.png",units = "px", width=800, height=600)
plot
dev.off()
