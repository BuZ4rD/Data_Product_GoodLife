library(shiny)
library(openxlsx)

url <- "https://goodlife.leeds.ac.uk/wp-content/uploads/sites/20/2018/01/GoodLifeWithinPB_SupplementaryData.xlsx"
data.planet <- read.xlsx(url,sheet = 2)
data.social <- read.xlsx(url,sheet = 3)
countries <- unique(data.planet[,1])
planetb_list <- colnames(data.planet[,-1])
socialt_list <- colnames(data.social[,-1])

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Good Life Comparison App"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("Country1",
                        "Select Country 1",
                        choices = countries, selected = "Sri Lanka"),
            selectInput("Country2",
                        "Select Country 2",
                        choices = countries, selected = "France"),
            checkboxGroupInput("PlanetB", 
                           "Planet Boundaries",
                           choices = planetb_list,
                           choiceNames = planetb_list,
                           selected = planetb_list),
            checkboxGroupInput("SocialT", 
                            "Social Threshold",
                            choices = socialt_list,
                            choiceNames = socialt_list,
                            selected = socialt_list)
        ),
        # Show a plot of the generated distribution
        mainPanel(
            h2(textOutput("selected_c1")),
            splitLayout(
                plotOutput("barp1p"),
                plotOutput("barp1s")
            ),
            h2(textOutput("selected_c2")),
            splitLayout(
                plotOutput("barp2p"),
                plotOutput("barp2s")
            )
        ))
))
