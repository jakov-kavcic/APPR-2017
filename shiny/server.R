library(shiny)

shinyServer(function(input, output) {
  
  output$Ap <- renderPlot({
    data_Ap <- all_products %>% filter(PRODUCT==input$PR_Ap &
                                      INDIC_NRG==input$INDIC_NRG_Ap &
                                      GEO==input$GEO_Ap & 
                                      TIME>=input$TIME_Ap[1] &
                                      TIME<=input$TIME_Ap[2]) %>% drop_na()
    validate(need(nrow(data_Ap) > 0, "Ni podatkov"))
    ggplot(data_Ap, aes(x=TIME,y=Value/1000,color=GEO)) +
        geom_line(aes(group=GEO)) +
      geom_smooth(method=lm,aes(x=TIME,y=Value/1000),col="blue") + 
        theme_bw() + xlab("Leto") +
        ylab("tisoče terajoulov")
    
  })
  
  output$Pd <- renderPlot({
    data_Pd <- iz_leta_v_leto %>% filter(GEO==input$GEO_Pd &
                                        INDIC_NRG==input$INDIC_NRG_Pd &
                                        TIME<=input$TIME_Pd[2] &
                                        TIME>=input$TIME_Pd[1] )%>% drop_na()
    validate(need(nrow(data_Pd) > 0, "Ni podatkov"))
    ggplot(data_Pd)+
      aes(x=TIME,y=Rast,color=GEO)+
      geom_line() + 
      geom_smooth(method=lm,aes(x=TIME,y=Rast),col="blue") +
      xlab("Leto") + 
      ylab("%")
  })
  
  output$Sl <- renderPlot({
    data_Sl <- rast_01_15 %>% filter(!(GEO %in% c("Bosnia and Herzegovina","Estonia")) & PRODUCT==input$PR_Sl & INDIC_NRG==input$INDIC_NRG_Sl)%>% drop_na()
    validate(need(nrow(data_Sl) > 0, "Ni podatkov"))
    ggplot(data_Sl)+
      aes(x=reorder(GEO,-Rast),y=Rast) + 
      geom_bar(stat = "identity")+
      guides(fill=FALSE) +
      xlab("Država") + 
      ylab("%") +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  
  output$Dpp <-  renderPlot({
    data_Dpp <- delez %>% filter(GEO==input$GEO_Dpp & TIME==input$TIME_Dpp &
                                  INDIC_NRG==input$INDIC_NRG_Dpp) %>% drop_na()
    validate(need(nrow(data_Dpp) > 0, "Ni podatkov"))
    ggplot(data_Dpp) +
      aes(x="",y=Delez, fill=PRODUCT) + 
      xlab("")+ylab("")+
      geom_bar(stat="identity",width = 1) +
      coord_polar("y",start=0) 
  })
  output$T_Dpp <- renderTable({
   T_Dpp <-  delez %>% filter(GEO==input$GEO_Dpp & TIME==input$TIME_Dpp &
                                   INDIC_NRG==input$INDIC_NRG_Dpp) %>% drop_na()
   validate(need(nrow(T_Dpp) > 0, "Ni podatkov"))
   colnames(T_Dpp) <- c("Država", "Leto" ,"Produkt","Vrsta podatkov","Delež v %" )
   T_Dpp
  })
  
})
