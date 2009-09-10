module Sitemaps

  class Generator

    attr_reader :configuration

    def initialize(configuration_object)
      self.configuration = configuration_object
    end

    def prepare
      Dir.mkdir configuration.dump_dir
    end

    def configuration=(object)
      unless object.is_a? Configuration
        raise InvalidConfigurationError.new('Not a sitemap configuration object!')
      end
      @configuration = object
    end

    def execute!
    end

    protected

    def download!
    end

    def compress!
    end

  end

end
