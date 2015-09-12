module SocialAnalyzer
  class Base
    attr_accessor :url, :options
    ##
    #initailize all the analyzer with search url and optional parameters
    #can access url and options in subclass
    def initialize(url, options = {})
      @url = url
      @options = options
    end

    def fetch
      raise NotImplementedError
    end

    ##config can be invoke in any subclass to get the analyzer configurations.
    def config
      SocialAnalyzer.config
    end
    
  end
end