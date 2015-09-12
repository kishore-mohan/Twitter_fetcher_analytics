##
#social analyzer maintains all the related configurations from yaml
#it generates dynamic analyzer method and invoke fetch method to get the details
#fetch method always return an Array
require "social_analyzer/twitter_analyzer"

module SocialAnalyzer

  class << self
    SOCIALANALYZER = YAML.load_file File.join(Rails.root, 'config/social_analyzer.yml')  

    SOCIALANALYZER["supported"].each do |service|
      define_method(service.to_sym) do |url: SOCIALANALYZER["query_host"], options: {}|
        class_name = service.to_s.split('_').map(&:capitalize).join
        SocialAnalyzer.const_get(class_name).new(url, options).fetch
      end
    end

    def config
      SOCIALANALYZER
    end

  end  
end