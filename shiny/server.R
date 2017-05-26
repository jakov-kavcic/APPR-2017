library(shiny)

shinyServer(function(input, output) {
  output$Ap <- renderPlot({
      ggplot(all_products %>% filter(PRODUCT==input$PR &
                                       INDIC_NRG==input$INDIC_NRG &
                                       GEO==input$GEO & 
                                       TIME>=input$TIME[1] &
                                       TIME<=input$TIME[2]),
             aes(x=TIME,y=Value,color=GEO)) +
        geom_line(aes(group=GEO)) +
      geom_smooth(method=lm,aes(x=TIME,y=Value),col="blue") + 
        theme_bw() + xlab("Leto") +
        ylab("terajoule")
    
  })
  
  output$Pd <- renderPlot({
    ggplot(iz_leta_v_leto %>% filter(GEO==input$GEO &
                                       INDIC_NRG==input$INDIC_NRG &
                                       TIME<=input$TIME[2] &
                                       TIME>=input$TIME[1] ))+
      aes(x=TIME,y=Rast,color=GEO)+
      geom_line() + 
      geom_smooth(method=lm,aes(x=TIME,y=Rast),col="blue") +
      xlab("Leto") + 
      ylab("%")
  })
  
  output$Sl <- renderPlot({
    ggplot(rast_01_15 %>% filter(!(GEO %in% c("Iceland","Latvia","Estonia","Albania","Montenegro","Cyprus","Turkey","Malta","Bosnia and Herzegovina")) &
                                   PRODUCT==input$PR & INDIC_NRG==input$INDIC_NRG))+
      aes(x=reorder(GEO,-Rast),y=Rast) + 
      geom_bar(stat = "identity")+
      guides(fill=FALSE) +
      xlab("Država") + 
      ylab("%") +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  
  output$Dpp <-  renderPlot({
    ggplot(delez %>% filter(GEO==input$GEO &
                              INDIC_NRG==input$INDIC_NRG)) +
      aes(x="",y=Delez, fill=PRODUCT) + 
      geom_bar(stat="identity") +
      coord_polar("y",start=0) 
  })
  
  output$T_Dpp <-  DT::renderDataTable( delez %>% filter(GEO==input$GEO & INDIC_NRG==input$INDIC_NRG) )
})
# 
# ggplot(iz_leta_v_leto %>% filter(GEO==drzave[3] &
#                                    INDIC_NRG==levels(iz_leta_v_leto$INDIC_NRG)[2] &
#                                    PRODUCT==produkti[3] &
#                                    TIME<=2015 &
#                                    TIME>=2001 ))+
#   aes(x=TIME,y=Rast,color=GEO)+
#   geom_line() +
#   geom_smooth(method=lm,aes(x=TIME,y=Rast),col="blue") +
#   xlab("Leto") +
#   ylab("%")
