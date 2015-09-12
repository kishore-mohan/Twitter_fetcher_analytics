require 'rails_helper'

describe SocialAnalyzer do
  describe "config" do
    subject {SocialAnalyzer.config}

    it "should give supported social analyze" do
      expect(subject["supported"]).to eq(["twitter_analyzer", "facebook"])
    end

    it "should give host" do
      expect(subject["query_host"]).to eq("refr.cc")
    end
  end

  describe "twitter fetch" do

    describe "twitter limit" do
      it "should give one tweet info" do
        expect(SocialAnalyzer.twitter_analyzer("refr.cc", {limit: 1}).size).to eq(1)
      end

      it "should give more than 2 info" do
        expect(SocialAnalyzer.twitter_analyzer("refr.cc", {limit: 4}).size).to be > 2
      end
    end

    describe "twitter since_id" do
      it "id should be greater than since id" do
        since_id = 642013121448546305
        info = SocialAnalyzer.twitter_analyzer("refr.cc", {limit: 1, since_id: since_id})
        expect(info.first.id).to be > since_id
      end
    end
  end

end