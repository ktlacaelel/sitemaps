module Sitemaps

  class Configuration

    attr_reader :generator, :domain, :targets, :dump_dir

    def initialize(yaml_file)
      @yaml_file = yaml_file
      validate!
    end

    protected

    def validate!
      validate_file!
      validate_generator!
      validate_domain!
      validate_dump_dir!
      validate_targets!
    end

    def validate_file!
      unless @yaml_file.is_a? String
        raise InvalidConfigurationError.new('Not a valid config filename')
      end
      unless File.exist? @yaml_file
        raise InvalidConfigurationError.new('File not found: %s' % @yaml_file)
      end
      @configuration = YAML::load_file(@yaml_file)
      unless @configuration.is_a? Hash
        raise InvalidConfigurationError.new('Incorrect yaml-syntax')
      end
      @configuration = @configuration['configuration']
    end

    def validate_generator!
      unless @configuration.keys.include? 'generator'
        raise InvalidConfigurationError.new('Missing generator in config')
      end
      if @configuration['generator'].nil? || @configuration['generator'] == ''
        raise InvalidConfigurationError.new('Please specify a generator')
      end
      @generator = @configuration['generator']
    end

    def validate_domain!
      unless @configuration.keys.include? 'domain'
        raise InvalidConfigurationError.new('Missing domain in config')
      end
      if @configuration['domain'].nil? || @configuration['domain'] == ''
        raise InvalidConfigurationError.new('Please specify a domain')
      end
      @domain = @configuration['domain']
    end

    def validate_targets!
      unless @configuration.keys.include? 'targets'
        raise InvalidConfigurationError.new('Missing targets in config')
      end
      if !@configuration['targets'].is_a?(Array) || @configuration['targets'].size == 0
        raise InvalidConfigurationError.new('Please specify some targets')
      end
      @targets = @configuration['targets']
    end

    def validate_dump_dir!
      unless @configuration.keys.include? 'dump_dir'
        raise InvalidConfigurationError.new('Missing dump_dir in config')
      end
      if @configuration['dump_dir'].nil? || @configuration['dump_dir'] == ''
        raise InvalidConfigurationError.new('Please specify a dump_dir')
      end
      @dump_dir = @configuration['dump_dir']
    end

  end

end
