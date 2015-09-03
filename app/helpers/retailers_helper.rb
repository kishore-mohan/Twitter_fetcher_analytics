module RetailersHelper
  def score_tooltip(hash)
    "<span style='text-align: left'>Tweets: #{hash['retail_tweets']} <br>" +
    "Retweets: #{hash['retweets']} <br>" +
    "Favorites: #{hash['favorites']}</span>"
  end

  def format_tweet(tweet, retailer_tweets)
    formatted_text = tweet.text
    retailer_tweets.each do |rt|
      linkified = link_to(rt.expanded_url, rt.twitter_url, target: "_blank")
      formatted_text = formatted_text.gsub(rt.twitter_url, linkified)
    end

    formatted_text
  end
end
