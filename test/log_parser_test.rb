require 'minitest/autorun'
require_relative '../lib/log_parser'

class LogParserTest < Minitest::Test
  def path_to_log(relative_path)
    File.join(File.dirname(__FILE__), relative_path)
  end

  def test_urls_by_page_views_case_1
    path_to_log = path_to_log('fixtures/log_example_1.log')
    log_parser = LogParser.new(path_to_log)
    expected_result = [
      { url: '/help_page/1', page_views: 4 },
      { url: '/home', page_views: 2 },
      { url: '/index', page_views: 1 },
      { url: '/contact', page_views: 1 },
      { url: '/about/2', page_views: 1 },
      { url: '/about', page_views: 1 },
    ]

    assert_equal(log_parser.urls_by_page_views, expected_result)
  end

  def test_urls_by_unique_page_views_case_1
    path_to_log = path_to_log('fixtures/log_example_1.log')
    log_parser = LogParser.new(path_to_log)
    expected_result = [
      { url: '/help_page/1', page_views: 4 },
      { url: '/home', page_views: 2 },
      { url: '/index', page_views: 1 },
      { url: '/contact', page_views: 1 },
      { url: '/about/2', page_views: 1 },
      { url: '/about', page_views: 1 },
    ]

    assert_equal(log_parser.urls_by_unique_page_views, expected_result)
  end

  def test_both_methods_equal_for_simple_set
    path_to_log = path_to_log('fixtures/log_example_1.log')
    log_parser = LogParser.new(path_to_log)

    assert_equal(log_parser.urls_by_unique_page_views, log_parser.urls_by_page_views)
  end

  def test_both_methods_not_equal_for_complex_set
    path_to_log = path_to_log('fixtures/webserver.log')
    log_parser = LogParser.new(path_to_log)

    assert(log_parser.urls_by_unique_page_views != log_parser.urls_by_page_views)
  end

  def test_urls_by_unique_page_views_case_2
    path_to_log = path_to_log('fixtures/webserver.log')
    log_parser = LogParser.new(path_to_log)
    expected_result = [
      { url: '/index', page_views: 23 },
      { url: '/home', page_views: 23 },
      { url: '/help_page/1', page_views: 23 },
      { url: '/contact', page_views: 23 },
      { url: '/about/2', page_views: 22 },
      { url: '/about', page_views: 21 },
    ]

    assert_equal(log_parser.urls_by_unique_page_views, expected_result)
  end
end
