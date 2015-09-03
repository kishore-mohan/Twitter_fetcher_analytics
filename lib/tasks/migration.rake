namespace 'migration' do
  desc "will retrieve tweets with refer.cc links"
  task "retrieve_tweets" => "environment" do
    retailer_codes = (ENV['RETAILERS'] || ENV['retailers'] || '').split(",")
    from_date = ENV['FROM_DATE'] || ENV['from_date']
    limit     = ENV['LIMIT'] || ENV['limit']

    helper = TwitterHelper.new(retailer_codes, :from_date => from_date, :limit => limit)

    puts "\n** fetching tweets with this criteria:"
    puts "  retailers: #{retailer_codes.empty? ? 'all' : retailer_codes.join(", ") }"
    puts "  from_date: #{from_date.inspect}" if from_date
    puts "  limit: #{limit || TwitterHelper::DEFAULT_LIMIT}"

    helper.search_tweets[:meta]

    puts "DONE"
  end
end
