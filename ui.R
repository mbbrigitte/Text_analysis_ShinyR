# ui.R  user interface 
# Layout
#library(devtools)
#library(shinyapps)
#deployApp()
shinyUI(navbarPage("",id='inTabset', #inTabset needed to change active Tab in server.R according to ActionButton
#    tags$head(includeScript("google-analytics.js")), #see  http://shiny.rstudio.com/articles/google-analytics.html                  
    tabPanel("Sentiment Analysis and Keyword Extraction",value="panel1", 
      fluidPage(#theme = "bootstrap.css",
       titlePanel(h1("The Data Journalist: Summarize My Text")),
       img(src = "sentiment-happy1.jpg",class="img-responsive",alt="Missing figure showing happy and unhappy face"),
              h3("What can this app do?"),
              p("Assume you have a very long email or article you don't want to read just now. If you copy
                the text in the box below and click 'Go!', our app analyzes your 
                text. It will tell you whether the person wrote it in a positive or negative
                mood. It will also extract the most important keywords so that you don't have 
                to read it all and still know what it is about. Or try it with a recent
                newspaper article. Just paste a text in the field below. The longer the text the  
                more accurate."),
       fluidRow(
         h3(""),
       column(4,
              h4('Enter text'),
              tags$style(type="text/css","textarea {width:100%}"),
              tags$textarea(id="variableSearch", rows=15, cols=45, "Paste your text here")
              ),
       column(2,
              h3(""),
              p(),
              p(),
              sliderInput("variableKeywords",
                          label = "Number of keywords you want to find",
                          min=1,max=10,value=3,step=1),
              helpText('Press Go!'),
              actionButton("goButton", label="Go!") #icon=NULL
       ),
       column(6,  # the larger right panel
              h3("Results from your text"),
              h5(textOutput("textreg")), 
              h5('The sentiment of your text was identified as'),
              h4(textOutput("text2"),align = "center"),
              tags$head(tags$style("#text2{background-color: lightgrey;
                                   color: black;
                                   font-style: italic;
                                   }"
           )
              ),
           p(),
           h5('We identified that your text belongs to the topic:'),
           h4(textOutput("text3"),align = "center"),
           tags$head(tags$style("#text3{background-color: lightgrey;
                                color: black;
                                font-style: italic;
                                }"
                         )
           ),
           #HTML(paste(tags$span(h5(strong(style="color:darkblue", textOutput("numFAR")))),
           #          sep = ""))),
           p(),
           h5('The keywords summarizing your text are:'),
           h4(textOutput("text4"),align = "center"),
           tags$div(tags$style("#text4{background-color: lightgrey;
                               color: black;
                               font-style: italic;
                               }"
                         )
           ),
           helpText('If you see a NA in your keywords above or an error message, your text 
                    was too short to extract keywords, or the number of keywords
                    chosen on the left was too large. Either try another text
                    or just paste your text in the field two times.'),
           plotOutput("plot1")
           )#this ends the main panel (right side)
              ),# end fluidrow 12 total columns
        fluidRow(
          column(10,
                 helpText(paste("Contact: "),a("brigitte.mueller@yahoo.ca", href="mailto:brigitte.mueller@yahoo.ca"))
                   )
             # here ends fluidrow
      )# fluidpage ends here
    )), #closing the first navigation bar page

tabPanel("Info and Feedback",
         fluidPage(
           fluidRow(
             column(2, 
                    br()                           
             ),
             column(8,             
                    withMathJax(),
                    h3('Short info:'),
                    p("The sentiment analysis has been performed through DatumBox API ",a("(Click)",
                    href="http://www.datumbox.com/machine-learning-api/",target="_blank"),",
                      and the keyword analysis with the R-package tm stopwords(SMART)."),
                    p("This app is part of an article on the topic 'the basic income'
                      published by ",a("The Data Journalist",
                             href="http://thedatajournalist.com/2016/02/12/basic-income/",target="_blank"),"."),
                    br(),
                    h3('For any comments or to obtain source code contact:'),
                    p(a("brigitte.mueller@yahoo.ca", href="mailto:brigitte.mueller@yahoo.ca"))                    ),
                    column(2, 
                          br()                           
             )
           )
         )
)   )
)


#textInput("from", "From:", value="from@gmail.com (optional)"),
#textInput("subject", "Subject:", value=""),
#actionButton("send", "Send mail"),
#textInput("message","Message:", value="This feedback form is not tested yet. Better write an email for now.")
# On the server side, this option was like the following, but probably not possible without shiny Pro account:
# observe({
#   if(is.null(input$send) || input$send==0) return(NULL)
#   from <- isolate(input$from)
#   to <- 'brigitte.mueller@yahoo.ca'
#   subject <- isolate(input$subject)
#   msg <- isolate(input$message)
#   sendmail(from, to, subject, msg)
# })



  