findkeys <- function(inputtext){
    
  #partly from: http://www.r-bloggers.com/create-twitter-wordcloud-with-sentiments/
  library (twitteR)
  library(httr)
  library(methods)
  
  
  # to make this run, find datumbox API for yourself following
  #http://thinktostart.com/sentiment-analysis-on-twitter-with-datumbox-api/
  newsearch = inputtext
  
  ####   Can only do 1000 calls per day   #########
  
  library(RCurl)
  library(RJSONIO)
  library(stringr)
  library(tm)
  
  # Then we get the text from these tweets and remove all the unwanted chars:
  # get text
  #tweet_txt = sapply(newsearch, function(x) x$getText())
  tweet_txt = newsearch
  
  # clean text
  tweet_clean = clean.text(tweet_txt)
  tweet_num = length(tweet_clean)
  
  
  # In the next step we apply the sentiment analysis function 
  #getSentiment() to every tweet text and save the result in our dataframe.
  # Then we delete all the rows which don´t have a sentiment score. 
  #This sometimes happens when unwanted characters survive our cleaning procedure.
  
  # apply function getSentiment
  db_key = 'b34707f84e4cde3cfdbe60d43dcdd589'
  #db_key = '95cb2e2880d7a13b1d3d46c6e57275f2'
  # apply function getSentiment
  tmp = getSentiment(tweet_clean, db_key)
  
  sentiment = tmp$sentiment
  topic = tmp$topic
  
  # tokenize on space and output as a list:
  doc.list <- strsplit(tweet_clean, "[[:space:]]+")
  
  # compute the table of terms:
  term.table <- table(unlist(doc.list))
  term.table <- sort(term.table, decreasing = TRUE)
  
  # remove terms that are stop words or occur fewer than 2 times:
  stop_words = stopwords("SMART")
  del <- names(term.table) %in% stop_words  | term.table < 2
  term.table <- term.table[!del]
  vocab <- names(term.table)  
  
  return(list(sentiment=sentiment,topic=topic,vocab=vocab))
}

  
  clean.text <- function(some_txt)
  {
    some_txt = gsub("\n", " ", some_txt)
    some_txt = gsub("@\\w+", " ", some_txt)
    some_txt = gsub("[[:punct:]]", " ", some_txt)
    some_txt = gsub("[[:digit:]]", " ", some_txt)
    some_txt = gsub("\\'", " ", some_txt)
#  some_txt = gsub("\\'", " ", some_txt)
#    some_txt = gsub("\\"", " ", some_txt)
#    some_txt = gsub("\\"", " ", some_txt)
    some_txt = gsub("http\\w+", "", some_txt)
    some_txt = gsub(".net", "", some_txt)
    some_txt = gsub(".com", "", some_txt)
    #some_txt = gsub("[ \t]{2,}", "", some_txt)
    some_txt = gsub("^\\s+|\\s+$", "", some_txt)
    #some_txt = gsub(""", " ", some_txt)
    # define "tolower error handling" function
    try.tolower = function(x)
    {
      y = NA
      try_error = tryCatch(tolower(x), error=function(e) e)
      if (!inherits(try_error, "error"))
        y = tolower(x)
      return(y)
    }
    
    some_txt = sapply(some_txt, try.tolower)
    some_txt = some_txt[some_txt != ""]
    
    return(some_txt)
  }
  getSentiment <- function (text, key){
    
    text <- URLencode(text);
    
    #save all the spaces, then get rid of the weird characters that break the API, then convert back the URL-encoded spaces.
    text <- str_replace_all(text, "%20", " ");
    text <- str_replace_all(text, "%\\d\\d", "");
    text <- str_replace_all(text, " ", "%20");
    
  #  if (str_length(text) > 360){
   #   text <- substr(text, 0, 359);
    #}
    ##########################################
    
    data <- getURL(paste("http://api.datumbox.com/1.0/SentimentAnalysis.json?api_key=", key, "&text=",text, sep=""))
    
    js <- fromJSON(data, asText=TRUE);
    
    # get mood probability
    sentiment = js$output$result
    
    ###################################
    ##################################
    
    data <- getURL(paste("http://api.datumbox.com/1.0/TopicClassification.json?api_key=", key, "&text=",text, sep=""))
    
    js <- fromJSON(data, asText=TRUE);
    
    # get mood probability
    topic = js$output$result
    
    ##################################
    
    return(list(sentiment=sentiment,topic=topic))
  }
  
