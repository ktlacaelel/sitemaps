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
      download!
      compress!
    end

    protected

    def download!
      ensure_dump_dir
      Net::HTTP.start(@configuration.generator, '3000') do |http|
        @configuration.targets.each do |target|
          store_downloaded_data target, http.get(target).body
        end
      end
    end

    def compress!
      ensure_compress_dir
      Dir.glob(download_path + '/*').each do |file|
        Zlib::GzipWriter.open(get_gzip_filename(file)) do |gz|
          gz.write File.read(file)
        end
      end
    end

    def get_gzip_filename(long_path)
      File.join(compress_path, File.basename(long_path) + '.gz')
    end

    def ensure_dump_dir
      [@configuration.dump_dir, download_path].each do |path|
        Dir.mkdir path unless File.exist? path
      end
    end

    def ensure_compress_dir
      unless File.exist? compress_path
        Dir.mkdir compress_path
      end
    end

    def store_downloaded_data(target, data)
      File.open(download_target_for(target), 'w+') do |file|
        file.write data
      end
    end

    def compress_path
      @compress_path ||= File.join(@configuration.dump_dir, @configuration.dump_dir)
    end

    def download_target_for(target)
      File.join(download_path, File.basename(target))
    end

    def download_path
      File.join(@configuration.dump_dir, 'downloads')
    end

  end

end
