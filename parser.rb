require_relative 'lib/log_parser'

path_to_log = ARGV[0]
log_parser = LogParser.new(path_to_log)

results = {
  page_views: log_parser.urls_by_page_views,
  unique_page_views: log_parser.urls_by_unique_page_views
}

pp results
