
#Analiza podatkov

# Funkcija za izračun rasti med leti 2000 in 2015
rast_ <- function(d,p,i,t_1,t_2){
  r <- all_products[all_products$TIME==t_1 & 
                                 all_products$GEO==d & 
                                 all_products$PRODUCT==p & 
                                 all_products$INDIC_NRG==i,"Value"]/
        all_products[all_products$TIME==t_2 & 
                                 all_products$GEO==d & 
                                 all_products$PRODUCT==p & 
                                 all_products$INDIC_NRG==i,"Value"]-1
  return(r)
}

# Rast iz leta v leto

iz_leta_v_leto <- all_products %>%
  mutate(Rast=0) %>%
  select(TIME,GEO,INDIC_NRG,Rast) %>%
  distinct() %>%
  drop_na()

for(i in 2001:2015){
  for(d in drzave){
    for(v in levels(all_products$INDIC_NRG)){
    iz_leta_v_leto[iz_leta_v_leto$TIME==i  & iz_leta_v_leto$INDIC_NRG==v & iz_leta_v_leto$GEO==d,"Rast"] <- round(all_products[all_products$TIME==i & all_products$GEO==d  & all_products$INDIC_NRG==v & all_products$PRODUCT=="All products","Value"]/
      all_products[all_products$TIME==i-1 & all_products$PRODUCT=="All products" & all_products$GEO==d  & all_products$INDIC_NRG==v,"Value"] - 1,4)*100
    }
  }
}
iz_leta_v_leto <- iz_leta_v_leto[is.finite(iz_leta_v_leto$Rast) & abs(iz_leta_v_leto$Rast)<=1000,] %>% drop_na()

# Rast med leti 2001 in 2015
rast_01_15 <- all_products[all_products$TIME %in% c(2001,2015),c(2,3,4)] %>% drop_na() %>% distinct()%>%
  mutate("Rast"=rast_(GEO,PRODUCT,INDIC_NRG,2001,2015)*100) %>% filter(Rast!=Inf) %>% drop_na()

#Kovarianca 
#Je za popravt rast_porabe v iz_leta...
# co_p_i_g <- cov(rast_porabe[rast_porabe$GEO=="Germany","Rast"],
#               rast_izvoza[rast_izvoza$GEO=="Germany","Rast"])
# co_p_u_g <- cov(rast_porabe[rast_porabe$GEO=="Germany","Rast"],
#              rast_uvoza[rast_uvoza$GEO=="Germany","Rast"])
# co_u_i_g <- cov(rast_izvoza[rast_izvoza$GEO=="Germany","Rast"],
#               rast_uvoza[rast_uvoza$GEO=="Germany","Rast"])
# co_p_i_EU28 <- cov(rast_porabe[rast_porabe$GEO=="European Union (28 countries)","Rast"],
#               rast_izvoza[rast_izvoza$GEO=="European Union (28 countries)","Rast"])
# co_p_u_EU28 <- cov(rast_porabe[rast_porabe$GEO=="European Union (28 countries)","Rast"],
#               rast_uvoza[rast_uvoza$GEO=="European Union (28 countries)","Rast"])
# co_u_i_EU28 <- cov(rast_izvoza[rast_izvoza$GEO=="European Union (28 countries)","Rast"],
#               rast_uvoza[rast_uvoza$GEO=="European Union (28 countries)","Rast"])
# co_p_i_n <- cov(rast_porabe[rast_porabe$GEO=="Norway","Rast"],
#                    rast_izvoza[rast_izvoza$GEO=="Norway","Rast"])
# co_p_u_n <- cov(rast_porabe[rast_porabe$GEO=="Norway","Rast"],
#                    rast_uvoza[rast_uvoza$GEO=="Norway","Rast"])
# co_u_i_n <- cov(rast_izvoza[rast_izvoza$GEO=="Norway","Rast"],
#                    rast_uvoza[rast_uvoza$GEO=="Norway","Rast"])

#Delež v celoti
produkti <- levels(all_products$PRODUCT)[2:10]

delez <- all_products %>% filter(TIME==2015 & PRODUCT %in% produkti ) %>%
  add_column("Delez"=1) %>% select(GEO,PRODUCT,INDIC_NRG,Delez) %>% drop_na()

for(d in drzave){
  for(p in produkti){
    for(i in levels(all_products$INDIC_NRG)){
  delez$Delez[delez$GEO==d & delez$PRODUCT==p & delez$INDIC_NRG==i] <- round(all_products$Value[all_products$TIME==2015 & all_products$GEO==d & all_products$PRODUCT==p & all_products$INDIC_NRG==i]/
                                                                          all_products$Value[all_products$TIME==2015 & all_products$GEO==d & all_products$PRODUCT=="All products" & all_products$INDIC_NRG==i],3)*100
    }
  }
}

delez <- delez %>% drop_na() %>% filter(Delez!=0)

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

# Sestava uvoza, izvoza in porabe

sestava_p_EU28 <- ggplot(delez %>% filter(GEO=="European Union (28 countries)" &
                                            INDIC_NRG=="Gross inland consumption")) +
  aes(x="",y=Delez, fill=PRODUCT) + 
  geom_bar(stat="identity") +
  coord_polar("y",start=0) 
                                    
sestava_u_EU28 <- sestava_p_EU28 %+% filter(delez,GEO=="European Union (28 countries)" & 
                                              INDIC_NRG=="Imports")
sestava_i_EU28 <- sestava_p_EU28 %+% filter(delez,GEO=="European Union (28 countries)" & 
                                              INDIC_NRG=="Exports")
  
