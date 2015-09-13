* bin/setup implemented for the quick and reliable setup.
* Cleaned up existing code in TwiiterHelper
  -Issues*
  -unnecessary if conditions removed
  -exceptions are not handled
  -since query not exist in either twitter api and twitter gem. It's since_id completely misderived the api and that since parameter doesn't take any valuable input.
  -some variables are just added without any reference.
 * gem 
  -pry(debugging)
  -hashie(useful gem to extend the hash)
  -better-erros(debugging)

##SocialAnalyzer
* SocilaAnalyzer can handle multiple social network related data analytics. For the future purpose redesigned.
* Handling supported social network in yml so on run time we can disable any feature without restart.
* Each file have comments why added and guide to use it.
* Designed scalable and reliable social_analyzer to easily abstract and refactor the code in future.
* Specs are covered for only Social Analyzer.
* Existing rake task cleaned up and added new methods to invoke

##FrontEnd
* Each retailer can check there twitter trending.
* Can analyze the total tweets, Reach, Impressions, retweets and favorite counts.
* Retailer tweets also shown for each retailer with pagination option
* Lot more details are stored in database for doing more data analytics.
* Frontend is pretty much straight forward.

##Recommendation
* Elastic search for better data indexing.
* Auto scroll for tweets using will_pagiantion.
* Add more test case scenarios.
* Can represent graphical data to the retailer.
* Can add more detail analytics based on the business scope.
* Tweet fetch can also be available from retailer level.

##Run the application
 `bin/setup`
 `bundle exec rake migration:retrieve_tweets`

