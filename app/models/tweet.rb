##
#Tweet carries all the tweets from twitter which related to the retailer.
# when tweets added automatically tweets counts will increase in the retailer account
# all the attributes are related to the tweet. and each row carries one tweet detail  
# tweet_id is maintained to use since_id the maximum since_id can be last tweet fetched. 
  
class Tweet < ActiveRecord::Base
  belongs_to :retailer, counter_cache: :tweet_counts, 
    dependent: :destroy

end
