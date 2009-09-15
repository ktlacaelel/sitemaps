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
      compile!
    end

    protected

    def compile!
      compile_index
      compile_robots
    end

    def compile_index
      output = File.new(sitemaps_index_filename, 'w+')
      xml = Builder::XmlMarkup.new(:target => output, :indent => 2)
      xml.instruct! :version => '1.0', :encoding => 'UTF-8'
      xml.sitemapindex :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
        downloaded_maps.each do |map|
          xml.sitemap do
            xml.loc get_gzip_url(map)
            xml.lastmod Time.now.strftime('%Y-%m-%d')
          end
        end
      end
      output.close
      compress_file(sitemaps_index_filename, sitemaps_gziped_index_filename)
    end

    def compile_robots
      File.open(robots_filename, 'w+') do |rostob|
        rostob.puts 'Sitemap: %s/%s' % [@configuration.domain, sitemaps_gziped_index_filename]
      end
    end

    def robots_filename
      File.join(@configuration.dump_dir, 'robots.txt')
    end

    def sitemaps_index_filename
      File.join(@configuration.dump_dir, 'index.xml')
    end

    def sitemaps_gziped_index_filename
      File.join(@configuration.dump_dir, 'index.xml' + '.gz')
    end

    def download!
      ensure_dump_dir
      Net::HTTP.start(@configuration.generator, @configuration.generator_port) do |http|
        http.read_timeout = @configuration.generator_timeout
        @configuration.targets.each do |target|
          store_downloaded_data target, http.get(target).body
        end
      end
    end

    def compress!
      ensure_compress_dir
      downloaded_maps.each { |map| compress_file(map, get_gzip_filename(map)) }
    end

    def compress_file(source, target)
      Zlib::GzipWriter.open(target) { |gz| gz.write File.read(source) }
    end

    def downloaded_maps
      Dir.glob(download_path + '/*')
    end

    def get_gzip_filename(long_path)
      File.join(compress_path, File.basename(long_path) + '.gz')
    end

    def get_gzip_url(long_path)
      [
        @configuration.domain,
        @configuration.dump_dir,
        File.basename(long_path) + '.gz'
      ].join('/')
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
