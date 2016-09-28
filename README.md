# Text analysis with ShinyR - Semantic analysis

## Short
I published this app together with an article on [The Data Journalist](https://thedatajournalist.com/2016/02/12/basic-income/).
It is online at https://thedatajournalist.shinyapps.io/SentimentApp/ and works perfectly fine (last access June 8, 2016).

The app analyzes a text, finds keywords, the topic and the sentiment. It uses the datumbox sentiment api.

## More details

Save ui.R, server.R and WordCloud_Letters.R in the same directory. Open it with R, install shiny and deploy the app.

The ui.R is the user interface. It creates two tabs in the app, one with the app and the other one with background info and info on how to connect. The UI is made up of a png-File which must be stored in a folder called wwww. It also has some input fields and text output and a wordcloud as output.

The server.R file connects the input and output from the ui and calls the wordcloud function.

The WordCloud_Letter.R is a function that reads the text that is taken from the UI, cleans up the text (remove dots and question marks etc), then sends the cleaned text to the datumbox API to perform sentiment analysis and topic definition. It then removes 'stopwords' which are filler words in texts such as 'is', 'and', 'he' etc. and counts the most used keywords. It returns the keywords, the sentiment and the topic to the server, which is then displayed in the ui.

You need to register at http://api.datumbox.com to obtain a key that you have to put in WordCloud_Letters.R as db_key.

See the working app on https://thedatajournalist.shinyapps.io/SentimentApp/

