# Log parser

Simple training exercise for parsing simple request logs with "#{url} #{ip}" format for each line. 

To run against an example log execute:
```
ruby parser.rb data/webserver.log
```

The logic is encapsulated in `LogParser` class, which takes as attribute `path_to_log` (relative_path). Class exposes two instance methods - `urls_by_page_views` and `urls_by_unique_page_views`. As names suggest they will return collections of urls with corresponding page_view count in a descending order.

To run specs, first run `bundle install` to add minitest gem and then execute:
```
ruby test/log_parser_test.rb
```
