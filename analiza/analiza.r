
#Analiza podatkov

# Funkcija za izračun rasti med leti 2000 in 2015
rast_ <- function(d,p,i){
  r <- all_products[all_products$TIME==2015 & 
                                 all_products$GEO==d & 
                                 all_products$PRODUCT==p & 
                                 all_products$INDIC_NRG==i,"Value"]/
        all_products[all_products$TIME==2001 & 
                                 all_products$GEO==d & 
                                 all_products$PRODUCT==p & 
                                 all_products$INDIC_NRG==i,"Value"]-1
  return(r)
}
# Rast porabe

rast_porabe <- all_products %>% filter(INDIC_NRG=="Gross inland consumption") %>%
  mutate(Rast=0) %>% select(TIME,GEO,Rast) %>% distinct() %>% drop_na()

for(i in 2001:2015){
  for(d in drzave){
    rast_porabe[rast_porabe$TIME==i & rast_porabe$GEO==d,"Rast"] <- all_products[all_products$TIME==i & all_products$GEO==d & all_products$PRODUCT=="All products" & all_products$INDIC_NRG=="Gross inland consumption","Value"]/
      all_products[all_products$TIME==i-1 & all_products$GEO==d & all_products$PRODUCT=="All products" & all_products$INDIC_NRG=="Gross inland consumption","Value"] - 1
  }
}


# Rast izvoza

rast_izvoza <- all_products %>% filter(INDIC_NRG=="Exports") %>%
  mutate(Rast=0) %>% select(TIME,GEO,Rast) %>% distinct() %>% drop_na()

for(i in 2001:2015){
  for(d in drzave){
    rast_izvoza[rast_porabe$TIME==i & rast_porabe$GEO==d,"Rast"] <- all_products[all_products$TIME==i & all_products$GEO==d & all_products$PRODUCT=="All products" & all_products$INDIC_NRG=="Exports","Value"]/
      all_products[all_products$TIME==i-1 & all_products$GEO==d & all_products$PRODUCT=="All products" & all_products$INDIC_NRG=="Exports","Value"] - 1
  }
}

# Rast uvoza

rast_uvoza <- all_products %>% filter(INDIC_NRG=="Imports") %>%
  mutate(Rast=0) %>% select(TIME,GEO,Rast) %>% distinct() %>% drop_na()

for(i in 2001:2015){
  for(d in drzave){
    rast_uvoza[rast_porabe$TIME==i & rast_porabe$GEO==d,"Rast"] <- all_products[all_products$TIME==i & all_products$GEO==d & all_products$PRODUCT=="All products" & all_products$INDIC_NRG=="Imports","Value"]/
      all_products[all_products$TIME==i-1 & all_products$GEO==d & all_products$PRODUCT=="All products" & all_products$INDIC_NRG=="Imports","Value"] - 1
  }
}

# Rast med leti 2001 in 2015
rast_01_15 <- all_products[all_products$TIME %in% c(2001,2015),c(2,3,4)] %>% drop_na() %>% distinct()%>%
  mutate("Rast"=rast_(GEO,PRODUCT,INDIC_NRG)*100) %>% filter(Rast!=Inf) %>% drop_na()

#Kovarianca 

co_p_i_g <- cov(rast_porabe[rast_porabe$GEO=="Germany","Rast"],
              rast_izvoza[rast_izvoza$GEO=="Germany","Rast"])
co_p_u_g <- cov(rast_porabe[rast_porabe$GEO=="Germany","Rast"],
             rast_uvoza[rast_uvoza$GEO=="Germany","Rast"])
co_u_i_g <- cov(rast_izvoza[rast_izvoza$GEO=="Germany","Rast"],
              rast_uvoza[rast_uvoza$GEO=="Germany","Rast"])
co_p_i_EU28 <- cov(rast_porabe[rast_porabe$GEO=="European Union (28 countries)","Rast"],
              rast_izvoza[rast_izvoza$GEO=="European Union (28 countries)","Rast"])
co_p_u_EU28 <- cov(rast_porabe[rast_porabe$GEO=="European Union (28 countries)","Rast"],
              rast_uvoza[rast_uvoza$GEO=="European Union (28 countries)","Rast"])
co_u_i_EU28 <- cov(rast_izvoza[rast_izvoza$GEO=="European Union (28 countries)","Rast"],
              rast_uvoza[rast_uvoza$GEO=="European Union (28 countries)","Rast"])
co_p_i_n <- cov(rast_porabe[rast_porabe$GEO=="Norway","Rast"],
                   rast_izvoza[rast_izvoza$GEO=="Norway","Rast"])
co_p_u_n <- cov(rast_porabe[rast_porabe$GEO=="Norway","Rast"],
                   rast_uvoza[rast_uvoza$GEO=="Norway","Rast"])
co_u_i_n <- cov(rast_izvoza[rast_izvoza$GEO=="Norway","Rast"],
                   rast_uvoza[rast_uvoza$GEO=="Norway","Rast"])

#Grafi za poročilo

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

rast_EU28 <- ggplot(rast_porabe %>% filter(GEO=="European Union (28 countries)")) +
              aes(x=TIME,y=Rast,color=GEO)+
              geom_line() + 
              geom_smooth(method=lm,aes(x=TIME,y=Rast),col="blue") +
              xlab("Leto") + 
              ylab("%")

rast_Slo <- rast_EU28 %+% filter(rast_porabe,GEO=="Slovenia")

rast_Ger <- rast_EU28 %+% filter(rast_porabe ,GEO=="Germany")

rast_i_EU28 <- rast_EU28 %+% filter(rast_izvoza,GEO=="European Union (28 countries)")
              
rast_i_Slo <- rast_EU28 %+% filter(rast_izvoza,GEO=="Slovenia")

rast_i_Ger <- rast_EU28 %+% filter(rast_izvoza,GEO=="Germany")

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


#Regresija za napoved

EU_28 <- spread(all_products,INDIC_NRG,value = Value) %>% 
  filter(GEO=="European Union (28 countries)" & PRODUCT=="All products") 
colnames(EU_28)[5] <- "Gic"
fit_EU_28 <- loess(Gic~Exports+Imports-1,EU_28)
EU_28 <- EU_28 %>% 
 #mutate(ocena=as.integer(Exports*fit_EU_28$coefficients[1]+Imports*fit_EU_28$coefficients[2]))
  mutate(ocena=as.integer(fit_EU_28$fitted))
graf3 <- ggplot(EU_28,aes(x=TIME,y=Gic))+geom_line(aes(group=GEO))+geom_line(aes(x=TIME,y=ocena,group=GEO),col="red")



