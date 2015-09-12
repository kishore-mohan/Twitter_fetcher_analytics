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
    retailer_results = []

    client.search(twitter_config['query_host'], query).take(limit).each do |result|
      response = Hashie::Mash.new(result.to_hash)
      (response.entities.try(:urls) || []).each do |url|
        next unless url.display_url =~ /(^.*)(.#{twitter_config['query_host']})/ && $1  
        retailer_results << {retailer_code: $1}
        push_retailer($1) if store_in_db        
      end
    end   
    retailer_results 
  end

  private

  def push_retailer(code)
    Retailer.find_or_create_by(name: code)
  end

  def query
    @query ||= {since: from_date, filter: "links"}.reject { |k, v| v.blank?}
  end

  def twitter_config
    YAML.load_file File.join(Rails.root, 'config/twitter.yml')
  end
end
