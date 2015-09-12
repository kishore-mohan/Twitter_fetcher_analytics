namespace 'migration' do
  desc "will retrieve tweets with refer.cc links"
  task "retrieve_tweets" => "environment" do
    since_id = ENV['SINCE_ID'] || ENV['since_id']
    limit     = ENV['LIMIT'] || ENV['limit']

    if since_id || limit
      helper = Tweet.fetch_by_options(options: {since_id: since_id, limit: limit})
    else
      helper = Tweet.fetch!
    end

    puts "\n** fetching tweets with this criteria:"
    puts "  Since id: #{since_id.inspect}" if since_id
    p "#{helper.size} tweets created"

    puts "DONE"
  end
end
