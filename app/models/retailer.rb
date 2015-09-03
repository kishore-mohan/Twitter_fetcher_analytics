class Retailer < ActiveRecord::Base
  validate :name, :presence => true

  scope :sorted_by_name, -> { order('LOWER(name)') }
end
