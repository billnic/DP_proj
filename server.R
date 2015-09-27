library(shiny)
library(datasets)
data(mtcars)

df <- data.frame(Vehicles=rownames(mtcars),mtcars)[1]
mympg <- function(am, hp, wt){
        mg<- 34.00288 + 2.08371 * am - 0.03748 * hp - 2.87858 * wt 
        mg
}
emissions<-function(mpg,distance,days,weeks){
              emit<- distance * 2 * days * weeks / mpg * 18.07 / 2000
              emit
}
shinyServer(
        function(input, output) {
                currentemissions <- reactive({
                        emissions(mtcars$mpg, input$distance, input$days, input$weeks)
                                     })
                currentmpg<-reactive({
                         mympg(as.numeric(input$am),as.numeric(input$hp),as.numeric(input$wt/1000))
                         })
                myemissions <- reactive({
                        emissions(as.numeric(currentmpg()), input$distance, input$days, input$weeks)
                                })
                output$mpg <- renderUI({ 
                        HTML(paste("Based on a weight of <b>", input$wt / 1000, " lbs</b> and <b>", 
                                   input$hp , " hp,</b> your estimated annual carbon dioxide emissions is <font color='red'><b>", 
                                   round(myemissions(),2), " short tons </b></font>(US metric tons).")
                        )
                })
                output$allcars <- renderPlot({
                        df[1]<- lapply(df[1], as.character)
                        df$Tons<-as.numeric(currentemissions())
                        df$Color<-"red"
                        mycar<-c("My Car", as.numeric(myemissions()), "green")
                        df <- rbind(df,mycar)
                        df[2] <- lapply(df[2], as.numeric)
                        df <-df[order(df[,2]),]
                        par(las=2) # make label text perpendicular to axis
                        par(mar=c(4,8,2,2)) # increase y-axis margin.
                        barplot(df$Tons, names.arg=df$Vehicle, col = df$Color, 
                                main="Annual Tons of Carbon Dioxide Emited from Driving to Work",
                                xlab="Tons",
                                cex.names=0.75, cex.axis=2,
                                horiz=TRUE,  las=1)
                 })
                }
)
