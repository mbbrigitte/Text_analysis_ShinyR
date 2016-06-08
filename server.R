source("WordCloud_Letters.R")
library(wordcloud)

shinyServer(function(input, output,session) {
#  observe({
  #    # use tabsetPanel 'id' argument to change tabs
  #    if (input$calc.button > 0) {
  #   updateTabsetPanel(session, "inTabset", selected = "panel2")
  # } else {
  #   updateTabsetPanel(session, "inTabset", selected = "panel1")
  # }
  #})
  output$textreg <- renderText({
    input$goButton
    paste("You selected 
           ",input$variableKeywords," keywords.")
  })
  output$text2 <- renderText({
    if (input$goButton){
    findkeys(inputtext=input$variableSearch)$sentiment} else {
      return('Please enter text on the left and click go!')
    }
  })
  output$text3 <- renderText({
    if (input$goButton){
      findkeys(inputtext=input$variableSearch)$topic} else { return('--')}
   # paste("We identified the topic of your text as ",findkeys(inputtext=input$variableSearch)$topic,"and the following 
    #      list of keywords:")
    
  })
  output$text4 <- renderText({
    if (input$goButton){
      loutput = input$variableKeywords
    findkeys(inputtext=input$variableSearch)$vocab[1:loutput]
    } else { return('--')}
  })
  output$plot1 <- renderPlot({
    #pal <- brewer.pal(10,"Dark2")
   # wordcloud(d$word,d$freq,c(8,.3),2,,TRUE,TRUE,.15,pal)
    loutput = input$variableKeywords
    if(nchar(input$variableSearch) > 30) {
    if (input$goButton){
    wordcloud(findkeys(inputtext=input$variableSearch)$vocab[1:loutput])} 
    }})
  
})
#After calling your function, you can then access each of these with outlist$wholetable or outlist$temperature.



# Sys.setlocale(locale="English") 
#to publish you need this: rsconnect::setAccountInfo(name='summertemperature',token='2FE9675048EA3E82C210736C98A133BC',secret='<SECRET>')


# call the lineplot data  tempseries=Web_FAR(deltaT=input$variableTemp,input$variableRegion)$tempseries
