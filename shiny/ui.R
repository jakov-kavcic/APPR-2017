library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Energetika v Evropi"),
  
  tabsetPanel(
      tabPanel("Agregatni podatki",
               sidebarPanel(
                 selectInput(inputId = "INDIC_NRG_Ap", 
                             label="Vrsta podatkov", 
                             c('Uvoz' ="Imports",
                               'Izvoz' ="Exports",
                              'Poraba' ="Gross inland consumption")),
                 selectInput(inputId="GEO_Ap",
                             "Država",
                             drzave),
                 selectInput(inputId="PR_Ap",
                             "Produkt",
                             levels(rast_01_15$PRODUCT)),
                sliderInput("TIME_Ap",
                                 "Leto",
                                 min=2000,
                                 max=2015,
                                 value = c(2001,2008),
                                 step=1,
                                 ticks=TRUE)),
                mainPanel(
                plotOutput("Ap")
                )
               ),
      tabPanel("Procentualno gibanje",
               sidebarPanel(
                 selectInput(inputId = "INDIC_NRG_Pd", 
                             label="Vrsta podatkov", 
                             c('Poraba' ="Gross inland consumption",
                               'Uvoz' ="Imports",
                               'Izvoz' ="Exports"
                               )),
                 selectInput(inputId="GEO_Pd",
                             "Država",
                             drzave[2:38]),
                 sliderInput("TIME_Pd",
                             "Leto",
                             min=2000,
                             max=2015,
                             value = c(2001,2008),
                             step=1,
                             ticks=TRUE)),
               mainPanel(
                 plotOutput("Pd")
               )
               ),
      tabPanel("Sprememba med leti 2001 in 2015",
               sidebarPanel(
               selectInput(inputId = "INDIC_NRG_Sl", 
                           label="Vrsta podatkov", 
                           c('Uvoz' ="Imports",
                             'Izvoz' ="Exports",
                             'Poraba' ="Gross inland consumption")),
               selectInput(inputId="PR_Sl",
                           "Produkt",
                           levels(rast_01_15$PRODUCT))),
      mainPanel(
        plotOutput("Sl")
      )
      ),
      tabPanel("Delež posameznih produktov",
               sidebarPanel(
                 selectInput("GEO_Dpp",
                             "Država",
                             drzave),
                 selectInput("INDIC_NRG_Dpp",
                             "Vrsta podatkov",
                             c('Uvoz' ="Imports",
                               'Izvoz' ="Exports",
                               'Poraba' ="Gross inland consumption")),
                 selectInput("TIME_Dpp",
                             "Leto",
                             Leta)
                 ),
               mainPanel(
                 h3(plotOutput("Dpp")),
                 tableOutput("T_Dpp")
               )
               )
        
      )
      
        
      ))
      