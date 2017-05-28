
#Analiza podatkov

# Rast iz leta v leto

all_products.all <- all_products %>% filter(PRODUCT == "All products") %>% select(-PRODUCT)
iz_leta_v_leto <- all_products.all %>% mutate(TIME = TIME + 1) %>% rename(Old = Value) %>%
  inner_join(all_products.all) %>% transmute(TIME, GEO, INDIC_NRG,
                                             Rast = 100*(Value/Old - 1)) %>%
  drop_na() %>% filter(abs(Rast) <= 1000)

# Rast med leti 2001 in 2015
rast_01_15 <- all_products %>%
  filter(TIME == 2001) %>% select(-TIME) %>% rename(Old = Value) %>%
  inner_join(all_products %>% filter(TIME == 2015) %>% select(-TIME)) %>%
  transmute(GEO, PRODUCT, INDIC_NRG, Rast = 100*(Value/Old - 1)) %>%
  drop_na() %>% filter(abs(Rast) <= 1000)

#Kovarianca 

co_p_i_g <- cov(iz_leta_v_leto[iz_leta_v_leto$GEO=="Germany" & iz_leta_v_leto$INDIC_NRG=="Gross inland consumption","Rast"],
              iz_leta_v_leto[iz_leta_v_leto$GEO=="Germany" & iz_leta_v_leto$INDIC_NRG=="Exports","Rast"])
co_p_u_g <- cov(iz_leta_v_leto[iz_leta_v_leto$GEO=="Germany" &  iz_leta_v_leto$INDIC_NRG=="Gross inland consumption","Rast"],
             iz_leta_v_leto[iz_leta_v_leto$GEO=="Germany" & iz_leta_v_leto$INDIC_NRG=="Imports","Rast"])
co_u_i_g <- cov(iz_leta_v_leto[iz_leta_v_leto$GEO=="Germany" & iz_leta_v_leto$INDIC_NRG=="Exports","Rast"],
              iz_leta_v_leto[iz_leta_v_leto$GEO=="Germany" & iz_leta_v_leto$INDIC_NRG=="Imports","Rast"])
co_p_i_EU28 <- cov(iz_leta_v_leto[iz_leta_v_leto$GEO=="European Union (28 countries)" & iz_leta_v_leto$INDIC_NRG=="Gross inland consumption","Rast"],
              iz_leta_v_leto[iz_leta_v_leto$GEO=="European Union (28 countries)" & iz_leta_v_leto$INDIC_NRG=="Exports","Rast"])
co_p_u_EU28 <- cov(iz_leta_v_leto[iz_leta_v_leto$GEO=="European Union (28 countries)" & iz_leta_v_leto$INDIC_NRG=="Gross inland consumption","Rast"],
              iz_leta_v_leto[iz_leta_v_leto$GEO=="European Union (28 countries)" & iz_leta_v_leto$INDIC_NRG=="Imports","Rast"])
co_u_i_EU28 <- cov(iz_leta_v_leto[iz_leta_v_leto$GEO=="European Union (28 countries)" & iz_leta_v_leto$INDIC_NRG=="Exports","Rast"],
              iz_leta_v_leto[iz_leta_v_leto$GEO=="European Union (28 countries)" & iz_leta_v_leto$INDIC_NRG=="Imports","Rast"])
co_p_i_n <- cov(iz_leta_v_leto[iz_leta_v_leto$GEO=="Norway" & iz_leta_v_leto$INDIC_NRG=="Gross inland consumption","Rast"],
                   iz_leta_v_leto[iz_leta_v_leto$GEO=="Norway" &iz_leta_v_leto$INDIC_NRG=="Exports","Rast"])
co_p_u_n <- cov(iz_leta_v_leto[iz_leta_v_leto$GEO=="Norway" & iz_leta_v_leto$INDIC_NRG=="Gross inland consumption","Rast"],
                   iz_leta_v_leto[iz_leta_v_leto$GEO=="Norway" & iz_leta_v_leto$INDIC_NRG=="Imports","Rast"])
co_u_i_n <- cov(iz_leta_v_leto[iz_leta_v_leto$GEO=="Norway" &iz_leta_v_leto$INDIC_NRG=="Exports","Rast"],
                   iz_leta_v_leto[iz_leta_v_leto$GEO=="Norway" & iz_leta_v_leto$INDIC_NRG=="Imports","Rast"])

#Delež v celoti
products2015 <- all_products %>% filter(TIME == 2015) %>% select(-TIME) %>% drop_na()
delez <- products2015 %>% filter(PRODUCT == "All products") %>%
  select(-PRODUCT) %>% rename(Total = Value) %>%
  inner_join(products2015 %>% filter(PRODUCT != "All products")) %>%
  transmute(GEO, PRODUCT, INDIC_NRG, Delez = 100*Value/Total) %>%
  filter(Delez >= 0.05)

##Grafi za poročilo

#Rast med 2001 in 2015
uvoz_01_15 <- ggplot(rast_01_15 %>% filter(!(GEO %in% c("Iceland","Latvia","Estonia","Albania","Montenegro","Cyprus","Turkey","Malta","Bosnia and Herzegovina")) & PRODUCT=="All products" & INDIC_NRG=="Imports"))+
              aes(x=reorder(GEO,-Rast),y=Rast) + 
              geom_bar(stat = "identity")+
              guides(fill=FALSE) +
              xlab("Država") + 
              ylab("%") +
              theme(axis.text.x = element_text(angle = 90, hjust = 1))

izvoz_01_15 <- ggplot(rast_01_15 %>% filter(!(GEO %in% c("Iceland","Latvia","Estonia","Albania","Montenegro","Cyprus","Turkey","Malta","Bosnia and Herzegovina")) & PRODUCT=="All products" & INDIC_NRG=="Exports"))+
              aes(x=reorder(GEO,-Rast),y=Rast) + 
              geom_bar(stat = "identity")+
              guides(fill=FALSE) +
              xlab("Država") + 
              ylab("%") +
              theme(axis.text.x = element_text(angle = 90, hjust = 1))

poraba_01_15 <- ggplot(rast_01_15 %>% filter(!(GEO %in% c("Iceland","Latvia","Estonia","Albania","Montenegro","Cyprus","Turkey","Malta","Bosnia and Herzegovina")) & PRODUCT=="All products" & INDIC_NRG=="Gross inland consumption"))+
              aes(x=reorder(GEO,-Rast),y=Rast) + 
              geom_bar(stat = "identity")+
              guides(fill=FALSE) +
              xlab("Država") + 
              ylab("%") +
              theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Rast med leti
rast_EU28 <- ggplot(iz_leta_v_leto %>% filter(GEO=="European Union (28 countries)"& INDIC_NRG=="Gross inland consumption" & TIME<=2015)) +
              aes(x=TIME,y=Rast,color=GEO)+
              geom_line() + 
              geom_smooth(method=lm,aes(x=TIME,y=Rast),col="blue") +
              xlab("Leto") + 
              ylab("%")

rast_Slo <- rast_EU28 %+% filter(iz_leta_v_leto,GEO=="Slovenia"& INDIC_NRG=="Gross inland consumption")

rast_Ger <- rast_EU28 %+% filter(iz_leta_v_leto ,GEO=="Germany"& INDIC_NRG=="Gross inland consumption")

rast_i_EU28 <- rast_EU28 %+% filter(iz_leta_v_leto,GEO=="European Union (28 countries)"& INDIC_NRG=="Exports")
              
rast_i_Slo <- rast_EU28 %+% filter(iz_leta_v_leto,GEO=="Slovenia"& INDIC_NRG=="Exports")

rast_i_Ger <- rast_EU28 %+% filter(iz_leta_v_leto,GEO=="Germany"& INDIC_NRG=="Exports")

# Dinamika v TJ
graf2 <- ggplot(all_products %>% filter(PRODUCT=="All products" & 
                                 INDIC_NRG=="Gross inland consumption" & 
                                 GEO %in% c("Slovenia","Macedonia","Montenegro", "Croatia", "Serbia")),
                                aes(x=TIME,y=Value/1000,color=GEO)) +
                                geom_line(aes(group=GEO)) +
                                xlab("Leto") + ylab("tisoče terajoulov") +
                                ggtitle(paste0("Potrošnja južniih držav")) +
                                theme_bw()

graf1 <- ggplot(all_products %>% filter(PRODUCT=="All products" &
                                          INDIC_NRG=="Gross inland consumption" &
                                          GEO %in% c("Germany","France","Italy", "United Kingdom", "Spain","Poland")),
                                          aes(x=TIME,y=Value/1000,color=GEO)) +
                                          geom_line(aes(group=GEO)) +
                                          theme_bw() + xlab("Leto") +
                                          ylab("tisoče terajoulov") +
                                          ggtitle(paste0("Potrošnja severnih držav"))

# Sestava uvoza, izvoza in porabe

sestava_p_EU28 <- ggplot(delez %>% filter(GEO=="European Union (28 countries)" &
                                            INDIC_NRG=="Gross inland consumption")) +
  aes(x="",y=Delez, fill=PRODUCT) + 
  geom_bar(stat="identity",width = 1) +
  coord_polar("y",start=0) 
                                    
sestava_u_EU28 <- sestava_p_EU28 %+% filter(delez,GEO=="European Union (28 countries)" & 
                                              INDIC_NRG=="Imports")
sestava_i_EU28 <- sestava_p_EU28 %+% filter(delez,GEO=="European Union (28 countries)" & 
                                              INDIC_NRG=="Exports")
  
