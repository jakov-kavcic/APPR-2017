library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Energetika v Evropi"),
  
  tabsetPanel(
      tabPanel("Agregatni podatki",
               sidebarPanel(
                 selectInput(inputId = "INDIC_NRG", 
                             label="Vrsta podatkov", 
                             c('Uvoz' ="Imports",
                               'Izvoz' ="Exports",
                              'Poraba' ="Gross inland consumption")),
                 selectInput(inputId="GEO",
                             "Država",
                             drzave),
                 selectInput(inputId="PR",
                             "Produkt",
                             c(produkti,"All products")),
                sliderInput("TIME",
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
                 selectInput(inputId = "INDIC_NRG", 
                             label="Vrsta podatkov", 
                             c('Poraba' ="Gross inland consumption",
                               'Uvoz' ="Imports",
                               'Izvoz' ="Exports"
                               )),
                 selectInput(inputId="GEO",
                             "Država",
                             drzave[2:38]),
                 sliderInput("TIME",
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
      tabPanel("Sprememba med leti 2001 in 20015",
               sidebarPanel(
               selectInput(inputId = "INDIC_NRG", 
                           label="Vrsta podatkov", 
                           c('Uvoz' ="Imports",
                             'Izvoz' ="Exports",
                             'Poraba' ="Gross inland consumption")),
               selectInput(inputId="PR",
                           "Produkt",
                           levels(rast_01_15$PRODUCT))),
      mainPanel(
        plotOutput("Sl")
      )
      ),
      tabPanel("Delež posameznih produktov",
               sidebarPanel(
                 selectInput("GEO",
                             "Država",
                             drzave),
                 selectInput("INDIC_NRG",
                             "Vrsta podatkov",
                             c('Uvoz' ="Imports",
                               'Izvoz' ="Exports",
                               'Poraba' ="Gross inland consumption"))  
                 ),
               mainPanel(
                 plotOutput("Dpp"),
                 tableOutput("T_Dpp")
               )
               )
        
      )
      
        
      ))
      