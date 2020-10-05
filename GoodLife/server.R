library(shiny)
library(openxlsx)

url <- "https://goodlife.leeds.ac.uk/wp-content/uploads/sites/20/2018/01/GoodLifeWithinPB_SupplementaryData.xlsx"
data.planet <- read.xlsx(url,sheet = 2)
data.social <- read.xlsx(url,sheet = 3)
countries <- unique(data.planet[,1])
planetb_list <- colnames(data.planet[,-1])
socialt_list <- colnames(data.social[,-1])

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        output$barp1p <- renderPlot({
            # generate bins based on input$bins from ui.R
            country1 <- input$Country1
            filterP <- input$PlanetB
            height1p <- as.numeric(data.planet[data.planet$X1==country1,filterP])
            barplot(height1p,
                    main = " Planet Boundaries (if >1 => Overshoot",
                    names.arg = filterP,
                    las=2,
                    col=ifelse(height1p>1,"red","green"))
        })
        output$barp1s <- renderPlot({
            # generate bins based on input$bins from ui.R
            country1 <- input$Country1
            filterS <- input$SocialT
            height1s <- as.numeric(data.social[data.planet$X1==country1,filterS])
            barplot(height1s,
                    main = "Social Threshold (if >1 => Good life)",
                    names.arg = filterS,
                    las=2,
                    col=ifelse(height1s<1,"red","green"))
        })
        output$barp2p <- renderPlot({
            # generate bins based on input$bins from ui.R
            country2 <- input$Country2
            filterP <- input$PlanetB
            height2p <- as.numeric(data.planet[data.planet$X1==country2,filterP])
            barplot(height2p,
                    main = "Planet Boundaries (if >1 => Overshoot)",
                    names.arg = filterP,
                    las=2,
                    col=ifelse(height2p>1,"red","green"))
        })
        output$barp2s <- renderPlot({
            # generate bins based on input$bins from ui.R
            country2 <- input$Country2
            filterS <- input$SocialT
            height2s <- as.numeric(data.social[data.planet$X1==country2,filterS])
            barplot(height2s,
                    main = "Social Threshold (if >1 => Good life)",
                    names.arg = filterS,
                    las=2,
                    cex.axis = 0.5,
                    col=ifelse(height2s<1,"red","green"))
        })
        output$selected_c1 <- renderText({input$Country1})
        output$selected_c2 <- renderText({input$Country2})
})
