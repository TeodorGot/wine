
library(shiny)
library(ggplot2)
library(caret)
library(dplyr)
library(e1071)
wine<-read.csv("wine.csv")
wine$label <- as.factor(wine$label)
set.seed(1234)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
output$Plot <- renderPlot({
      #draw plot
      dataset<- filter(wine,
                       grepl(input$alcohol, alcohol),
                       grepl(input$residual.sugar, residual.sugar)
      )
      pl<-ggplot(dataset, aes(y=alcohol,x=residual.sugar)) + geom_point(aes(color=label),alpha=0.2) + scale_color_manual(values = c("#ae4554","#faf7ea")) + theme_dark()+xlim(0,20)+ylim(0,14)
      pl
  })
      # Renders the text for the prediction below the graph
 output$output <- renderPrint({
          # build model
          dataset<- filter(wine,
                           grepl(input$alcohol, alcohol),
                           grepl(input$residual.sugar, residual.sugar)
                            )
          intrain <- createDataPartition(y = dataset$label, p= 0.7, list = FALSE)
          training <- dataset[intrain,]
          testing <- dataset[-intrain,]
          trctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
          glm_mod <- train(label ~ alcohol+residual.sugar, data = training, method = "glm",
                           trControl=trctrl,
                           family="binomial"
                            )
          #predict according user output
          test_pred <- predict(glm_mod, newdata = testing)
         
          res<-confusionMatrix(test_pred, testing$label)
          res
      })
})


