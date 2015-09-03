require 'rails_helper'

describe TwitterHelper do
  describe 'search_tweets' do
    let(:limit) { 5 }
    subject { TwitterHelper.new(limit: limit).search_tweets }

    it 'does not work with more tweets than requested' do
      expect(subject[:tweets].size).to be <= 5
    end

    it 'creates retailers from the tweets' do
      expect { subject }.to change { Retailer.count }
    end
  end
end
