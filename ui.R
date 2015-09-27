library(shiny)
library(markdown)
# http://blueskymodel.org/gallon-gas
shinyUI(navbarPage("Driving to Work",
        # Application title
        tabPanel("Carbon Footprint"),

        sidebarLayout(
                sidebarPanel(
                        h3("Your drive:"),
                        sliderInput('distance', 'Distance to work:',value=15, min = 2, max = 100, step=1),
                        sliderInput('days', 'How many days per week:', value=5, min = 1, max = 7, step=1),
                        sliderInput('weeks', 'How many weeks per year:', value=48, min = 1, max = 52, step=1),
                        h3("Your car:"),
                        sliderInput('wt', 'Weight', min=500, max=5000, value=2000,step=10),
                        sliderInput('hp', 'Horsepower', min=20, max=400, value=200, step=1),
                        selectInput('am', 'Transmission',choices = list('Automatic' = 0, 'Manual' = 1), multiple=F,selected=0)
 
                ),
                
                mainPanel(
                        tabsetPanel(
                                
                                tabPanel("Application",
                                         h3("Results"),
                                         
                                         htmlOutput("mpg"),
                                         plotOutput("allcars")
                                         
                                ),
                                tabPanel("Documentation",
                                         h3("Fuel Cost Calculator"),
                                         br(),
                                         p("The 'Fuel Cost Calculator' app was developed 
                                           for the 'Developing Data Products' course offered by Coursera."),
                                         br(),
                                         p("This app calculates the annual amount of carbon dioxide emitted by your car
                                           from driving to work.  On average, one gallon of gasoline produces 18.07 
                                           pounds of carbon dioxide. If your car gets 20 miles-per-gallon and you drive
                                           10,000 miles in a year, you'll produce 4.5 short tons of carbon dioxide."),
                                           a("[Ref.](http://blueskymodel.org/gallon-gas)"),
                                         br(),
                                         br(),
                                          p("The amount of emissions depends on the gallons of gas consumed. The R 'mtcars'
                                            dataset in the 'datasets' library contains fuel consumption and 10 aspects of 
                                            automobile design and performance published in 1974 by the US magazine
                                            Motor Trend. To calculate the gallons consumed in a year by your vehicle,
                                            a regression line is fitted to this data on the variables horsepower, weight,
                                            and transmission type."),
                                          br(),
                                          br(),
                                         h3("Steps to run the calculation"),
                                         
                                         p("1. Enter your one-way distance from your home to work, the average number 
                                            of days you drive to work in a week, and the number of weeks you work in a year."),
                                         
                                         p("2. To estimated your vehicle's mpg, enter the weight and horsepower of your vehicle,
                                             and from the drop-down box, select the transmission type."),
                                         
                                         p("Your annual carbone dioxide emissions will appear along with a graph displaying your emissions
                                           compared to the emissions of all the vehicles in mtcars dataset."),
                                           
                                         p("The source code for ui.R and server.R files us available at: "),a("[GitHub](https://github.com/billnic/DP_proj).")
                                ),
                                tabPanel("Remarks",
                                         br(),
                                         h2("Get rid of your Volkswagen and if possible, get yourself a hybrid!"),
                                         br(),
                                         h2("Better yet, take public transportation or if possible, walk to work :).")
                                )
                                                                 )
                )
        )
)
)
