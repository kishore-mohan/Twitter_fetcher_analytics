class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :tweet_id, index: true
      t.string :user_name
      t.integer :retweet_count
      t.integer :followers_count
      t.integer :friends_count
      t.integer :favorite_count
      t.datetime :tweet_time
      t.text :text
      t.string :user_location
      t.references :retailer, index: true

      t.timestamps
    end
  end
end
