class Retailer < ActiveRecord::Base

  has_many :tweets
  validate :name, :presence => true

  scope :sorted_by_name, -> { order('LOWER(name)') }

  def impression
    tweets.sum(:followers_count) + tweets.sum(:friends_count)
  end

  def reach
    tweets.sum(:followers_count) 
  end

  def retweet_counts
    tweets.sum(:retweet_count)
  end

  def favorite_counts
    tweets.sum(:favorite_count)
  end
end
