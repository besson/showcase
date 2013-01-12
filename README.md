Recommender_analyzer
====================

A simple rails app to analyze results of [mahout recommender](http://mahout.apache.org/). 
In a simple usage of the mahout's recommender, we just have to provide to the tool a file containing at least "user_id,item_id" entries.
Then, Mahout's recommender generates a file describing the recommendations for each provided user_id. The goal of this application is to 
visualize the recommendation results easily. Through the recommender analyzer, you can check the user and the recommended items, to check the success of mahout recommendation.

The long term goal is to build a generic analyzer, for while, this analyzer is used to explore and validate some experiments performed with the [Netflix Prize base](http://www.netflixprize.com/community/viewtopic.php?pid=9615). In this use case, the analyzer provides the following features:

- checking the watched and recommended movies for a user
- retrieves the movie genres from [IMDB API](http://www.imdbapi.com) to facilitate the comparison

Observations:

- /helpers: contains scripts to parse and store into a database the input files of netflix prize base and mahout results
- /data: must contain all files used by the helper scripts
