require 'test_helper'

class GeneratorTest < Test::Unit::TestCase

  def setup
    @valid = 'test/data/valid_configuration_file.yml'
    @config = Sitemaps::Configuration.new(@valid)
  end

  should 'check for a sitemap configuration on instantiantion' do
    assert_raise (InvalidConfigurationError) do
      Sitemaps::Generator.new(nil)
    end
  end

  should 'prepare dump_dir' do
    Sitemaps::Generator.new(@config).prepare
    assert File.exist? 'sitemaps'
  end

  should 'get config' do
    config  = Sitemaps::Generator.new(@config).configuration
    assert_equal config.generator, 'http://localhost:3000'
  end

  should 'change config' do
    generator = Sitemaps::Generator.new(@config)
    @config.stub(:generator).returns('changed!')
    generator.change_config @config
    assert_equal generator.configuration.generator, 'changed!'
  end

  should 'should download sitemaps'
  should 'should gzip sitemaps'

end
