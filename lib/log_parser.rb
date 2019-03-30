class LogParser
  def initialize(path_to_log)
    @path_to_log = path_to_log
  end

  # Can take whole collection from the file or given
  # subset. Groups collection by urls and counts the
  # occurances of the request. Finally sorts the results
  # first by page_views, then by url, in descending order.
  #
  # @param page_views_collection [Array<String>] optional,
  #   subcollection of page_views to process
  #
  # @return [Array<Hash>] Array of Hashes with :url and :page_views
  #   keys, sorted in a descending order
  def urls_by_page_views(page_views_collection = nil)
    page_views_collection ||= all_page_views
    grouped_page_views = page_views_collection.group_by { |row| row[0] }
    formatted_results = format_page_view_results(grouped_page_views)

    sort_results(formatted_results)
  end

  # First groups page_views for same url and ip. Then
  # counts page_views on the limited collection from the input
  # file.
  #
  # @return [Array<Hash>] Array of Hashes with :url and :page_views
  #   keys, sorted in a descending order
  def urls_by_unique_page_views
    grouped_page_views = all_page_views.group_by { |row| [row[0], row[1]] }

    urls_by_page_views(grouped_page_views.keys)
  end

  private

  attr_reader :path_to_log

  def all_page_views
    log_content = File.read(path_to_log)

    log_content.split("\n").map { |row| row.split(' ') }
  end

  def format_page_view_results(grouped_page_views)
    grouped_page_views.map do |url, page_views|
      {
        url: url,
        page_views: page_views.count
      }
    end
  end

  # First by page_views, than by url, to have consistent
  # results. If we would only take page_views, equal values would
  # come in random order.
  def sort_results(formatted_results)
    formatted_results.sort do |a, b|
       [b[:page_views], b[:url]] <=> [a[:page_views], a[:url]]
    end
  end
end
