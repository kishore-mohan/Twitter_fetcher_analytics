##
#Tweet carries all the tweets from twitter which related to the retailer.
# when tweets added automatically tweets counts will increase in the retailer account
# all the attributes are related to the tweet. and each row carries one tweet detail  
# tweet_id is maintained to use since_id the maximum since_id can be last tweet fetched. 
# t.integer :tweet_id, index: true
# t.string :user_name
# t.integer :retweet_count
# t.integer :followers_count
# t.integer :friends_count
# t.integer :favorite_count
# t.datetime :tweet_time
# t.text :text
# t.string :user_location
# t.references :retailer, index: true
class Tweet < ActiveRecord::Base

  belongs_to :retailer, counter_cache: :tweet_counts,
    dependent: :destroy

  validates :tweet_id, :retailer_id, presence: true
  validates :tweet_id, uniqueness: true 

  class << self
    def fetch!
      cnt = []
      SocialAnalyzer.twitter_analyzer.each do |info|
        cnt << store_info!(info)
      end
      cnt.reject(&:blank?)
    end

    def fetch_by_options(options)
      cnt = []
      SocialAnalyzer.twitter_analyzer(options).each do |info|
        cnt << store_info!(info)
      end
      cnt.reject(&:blank?)
    end

    def store_info!(info)
      return create(tweet_id: info.id, user_name: info.name, text: info.text, retweet_count: info.retweet_count, 
        followers_count: info.follower_count, friends_count: info.friends_count, tweet_time: info.tweet_time,
        user_location: info.location, favorite_count: info.favorite_counts, 
        retailer_id: store_retailer(info)).id 
    end
    private :store_info!

    def store_retailer(info)
      Retailer.find_or_create_by( name: info.retailer ).id
    end
    private :store_retailer
  end
end
