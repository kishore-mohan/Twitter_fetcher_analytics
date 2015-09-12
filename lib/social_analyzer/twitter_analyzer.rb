require 'twitter'

module SocialAnalyzer
  class TwitterAnalyzer < Base

    DEFAULT_LIMIT = 1000
    ##
    #returns always an Array
    #if there is not retailers it give empty Array else gives Tweet info
    #API Exceptions are not handled only Twitter error handled
    def fetch
      infos = []
      client.search(url, query).take(limit).each do |result|
        response = Hashie::Mash.new(result.to_hash)
        infos << store_info(response)
      end 
      infos
      #TODO: Exception need to handled
      rescue Twitter::Error
        Rails.logger.error("Twitter fetch throwing error check the connection")
    end

    ##
    #Stores the tweet info with the retailer name validation
    #response should be hashie convert the json into hashie and pass it
    def store_info(response)
      return [] unless retailer = retailer(response.entities.try(:urls))
      TweetInfo.new(text: response.text, id: response.id, name: response.user.screen_name, retailer: retailer, 
        retweet_count: response.retweet_count, follower_count: response.user.followers_count, 
        friends_count: response.user.friends_count, tweet_time: response.created_at,
        location: response.user.location, favorite_count: response.favorite_counts)
    end

    ##
    #identifying retailers from display_url using twitter response
    #matching the retailer name using the url if didn't mathc it return nil
    def retailer(urls)
      (urls || []).each do |display_url|
        next unless display_url[:display_url] =~ /(^.*)(.#{url})/ && $1  
        return $1
      end
      name ||= nil
    end

    private

    def limit
      options[:limit] || DEFAULT_LIMIT
    end

    def client
      Twitter::REST::Client.new do |con|
        con.consumer_key    = config['twitter']['api_key']
        con.consumer_secret = config['twitter']['api_secret']
      end
    end

    ##since_id can be referred by either options or tweet maximum tweet id.
    # So when again try to fetch it will fetch from last tweet_id
    def since_id
      options[:since_id] || Tweet.maximum(:tweet_id).to_i
    end

    def query
      { since_id: since_id, filter: "links" }.reject { |k, v| v.blank?}
    end

  end

  class TweetInfo
    include Virtus.model

    attribute :text, String
    attribute :id, Integer
    attribute :retailer, String
    attribute :name, String
    attribute :retweet_count, Integer
    attribute :follower_count, Integer
    attribute :friends_count, Integer
    attribute :tweet_time, String
    attribute :location, String
    attribute :favorite_counts, Integer
  end
end