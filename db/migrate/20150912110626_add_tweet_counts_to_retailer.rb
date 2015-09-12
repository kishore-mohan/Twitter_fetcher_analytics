class AddTweetCountsToRetailer < ActiveRecord::Migration
  def change
    add_column :retailers, :tweet_counts, :integer
  end
end
