require 'rails_helper'

module SocialAnalyzer
  describe TwitterAnalyzer do
    let(:url) {"refr.cc"}
    let(:limit) { 5 }
    let(:fixtures) {"spec/fixtures/"}

    describe 'initialize' do
      subject { TwitterAnalyzer.new(url) }

      it "should give url refr.cc" do
        expect(subject.url).to eq(url)
        expect(subject.options).to eq({})
      end
    end

    describe 'initialize with otpions' do
      subject { TwitterAnalyzer.new(url, {since_id: 123})}

      it 'should give options of since_id' do
        expect(subject.options[:since_id]).to eq(123)
        expect(subject.options.size).to eq(1)
      end
    end

    describe 'find retailer' do
      subject { TwitterAnalyzer.new(url) }

      it "should give the name" do
        urls = [{ display_url: "cannabox.refr.cc/Z7QKBJ5"}]
        expect(subject.retailer(urls)).to eq("cannabox")
      end

      it "shouldn't give the name and return nil" do
        urls = [{ display_url: "cannaboxs/Z7QKBJ5"}]
        expect(subject.retailer(urls)).to be_nil

      end

      it "when two urls should give name" do
        urls = [{ display_url: "cannabox.refr.cc/Z7QKBJ5"},  {display_url: "cannaboxs/Z7QKBJ5"}]
        expect(subject.retailer(urls)).to eq("cannabox")
      end

      it "when urls empty should give nil" do
        urls = nil
        expect(subject.retailer(urls)).to be_nil      
      end
    end

    describe 'tweet store info' do
      let(:response) {eval File.read(fixtures+"response.json") }
      subject { TwitterAnalyzer.new(url).store_info(Hashie::Mash.new(response))}

      it "should give SocialAnalyzer::TweetInfo class" do
        expect(subject.class).to eq(SocialAnalyzer::TweetInfo)
      end

      it "should give tweet id from tweet_info" do
        expect(subject.id).to eq(642013121448546305)
      end

      it "should give tweet text referring the url" do
        expect(subject.text).to match(/Use my referral link/)   
      end

      it "shoulg give empty store info" do
        response = eval(File.read(fixtures+"wrong_tweet.json"))
        tweet = TwitterAnalyzer.new(url).store_info(Hashie::Mash.new(response))
        expect(tweet).to be_empty
      end
    
    end

  end
end