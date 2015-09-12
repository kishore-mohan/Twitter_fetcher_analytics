class Retailer < ActiveRecord::Base

  has_many :tweets
  validate :name, :presence => true

  scope :sorted_by_name, -> { order('LOWER(name)') }
end
