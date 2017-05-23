
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


graf2 <- ggplot(all_products %>% filter(PRODUCT=="All products" & 
                                 INDIC_NRG=="Gross inland consumption" & 
                                 GEO %in% c("Slovenia","Macedonia","Montenegro", "Croatia", "Serbia")),
       aes(x=TIME,y=Value,color=GEO)) +
  geom_line(aes(group=GEO)) +
  xlab("Leto") + ylab("terajoule") +
  ggtitle(paste0("Potrošnja južniih držav")) +
  theme_bw()

graf1 <- ggplot(all_products %>% filter(PRODUCT=="All products" &
                                          INDIC_NRG=="Gross inland consumption" &
                                          GEO %in% c("Germany","France","Italy", "United Kingdom", "Spain","Poland")),
  aes(x=TIME,y=Value,color=GEO)) +
  geom_line(aes(group=GEO)) +
  theme_bw() + xlab("Leto") +
  ylab("terajoule") +
  ggtitle(paste0("Potrošnja severnih držav"))







