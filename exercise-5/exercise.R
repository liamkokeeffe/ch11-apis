### Exercise 5 ###
install.packages("jsonlite")
install.packages("httr")
library(jsonlite)
library(dplyr)
library(httr)

api_key <- "20161a70117741c7896abde122e74721"

# Write a function that allows you to specify a movie, that does the following:
GetReview <- function(movie) {
  # Construct a search query using YOUR api key
  # The base URL is https://api.nytimes.com/svc/movies/v2/reviews/search.json?
  # Your parameters should include a "query" and an "api_key"
  # Note: the HTTR library will take care of spaces in the arguments
  # See the interactive console for more detail:https://developer.nytimes.com/movie_reviews_v2.json#/Console/GET/reviews/search.json
  
  
  # Request data using your search query
  base_uri <- "https://api.nytimes.com/svc/movies/v2/reviews/search.json?"
  query_params <- list(query=movie, api_key = api_key)
  
  response <- GET(base_uri, query=query_params)
  body <- content(response, "text")
  
  # What type of variable does this return?
  typeof(body)
  # Flatten the data stored in the `$results` key of the data returned to you
  results <- fromJSON(body)
  flattened <- flatten(results$results)
  # From the most recent review, store the headline, short summary, and link to full article each in their own variables
  headline <- flattened$headline
  short_summary <- flattened$summary_short
  link <- flattened$link.url
  
  # Return an list of the three pieces of information from above
  info <- list(headline = headline, summary = short_summary, link = link)
  info
}

# Test that your function works with a movie of your choice
GetReview("Incredibles 2")
