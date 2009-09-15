require 'test_helper'

class ConfigurationTest < Test::Unit::TestCase

  def setup
    @valid = 'test/data/valid_configuration_file.yml'
    @invalid = 'test/data/invalid_configuration_file.yml'
    @empty = 'test/data/empty_configuration_file.yml'
    @no_generator = 'test/data/no_generator_configuration_file.yml'
    @no_domain    = 'test/data/no_domain_configuration_file.yml'
    @no_targets   = 'test/data/no_targets_configuration_file.yml'
    @no_dump_dir  = 'test/data/no_dump_dir_configuration_file.yml'
  end

  # ============================================================================
  # YAML LOADING
  # ============================================================================

  should 'check if configuration file exists' do
    assert_raise(Sitemaps::InvalidConfigurationError) { Sitemaps::Configuration.new('a') }
    assert_raise(Sitemaps::InvalidConfigurationError) { Sitemaps::Configuration.new(nil) }
  end

  should 'load a configuration file' do
    Sitemaps::Configuration.new(@valid)
  end

  # ============================================================================
  # MISSING PARAMETERS
  # ============================================================================

  should 'throw an error when generator is not given' do
    assert_raise(Sitemaps::InvalidConfigurationError) { Sitemaps::Configuration.new(@no_generator) }
  end

  should 'throw an error when domain is not given' do
    assert_raise(Sitemaps::InvalidConfigurationError) { Sitemaps::Configuration.new(@no_domain) }
  end

  should 'throw an error when targets is not given' do
    assert_raise(Sitemaps::InvalidConfigurationError) { Sitemaps::Configuration.new(@no_targets) }
  end

  should 'throw an error when dump_dir is not given' do
    assert_raise(Sitemaps::InvalidConfigurationError) { Sitemaps::Configuration.new(@no_dump_dir) }
  end

  # ============================================================================
  # CONFIGURATION ACCESS
  # ============================================================================

  def config
    Sitemaps::Configuration.new(@valid)
  end

  should 'retrive generator' do
    assert_equal 'http://localhost:3000', config.generator
  end

  should 'retrive domain' do
    assert_equal 'http://example.com', config.domain
  end

  should 'retrive targets' do
    assert_equal ['/sitemap_for/users.xml'], config.targets
  end

  should 'retrive dump_dir' do
    assert_equal 'sitemaps', config.dump_dir
  end

end
