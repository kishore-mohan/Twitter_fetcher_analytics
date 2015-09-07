require 'twitter'

class TwitterHelper
  DEFAULT_LIMIT = 1000

  attr_accessor :client, :limit, :from_date

  # parameters:
  #   - limit (optional) = maximum number of results to fetch
  #   - from_date (optional) = tweets fetched only created from this date passed
  #                            values: today
  #                                    YYYY-MM-DD format dates
  def initialize(params={})
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = twitter_config['twitter']['api_key']
      config.consumer_secret = twitter_config['twitter']['api_secret']
    end

    @limit = params[:limit] || DEFAULT_LIMIT

    if params[:from_date]
      @from_date = params[:from_date] == "today" ? Date.today : Date.parse(params[:from_date])
    end
  end

  def search_tweets(store_in_db=true)
    parts = []
    parts << "#{twitter_config['query_host']}"
    if from_date
      parts << "since:#{from_date}"
    end
    query = parts.join(" ") + " filter:links"

    meta  = { }
    retailer_results = []

    client.search(query).take(limit).each do |result|
      code = nil

      result.to_hash[:entities][:urls].each do |url|
        if url[:expanded_url].to_s.include?(twitter_config['query_host'])
          code = url[:display_url].split(".#{twitter_config['query_host']}/").first
        end
      end

      if code
        retailer_results << {retailer_code: code}
      end
    end

    if store_in_db
      retailer_results.each do |retailer|
        if !Retailer.exists?(name: retailer[:retailer_code])
          Retailer.create!(name: retailer[:retailer_code])
        end
      end
    end

    {tweets: retailer_results}
  end

  private

  def twitter_config
    YAML.load_file File.join(Rails.root, 'config/twitter.yml')
  end
end
