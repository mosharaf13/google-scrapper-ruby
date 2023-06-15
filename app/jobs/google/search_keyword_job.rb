# frozen_string_literal: true

module Google
  class SearchKeywordJob < ApplicationJob
    queue_as :default

    def perform(search_stat_id:)
      search_stat = SearchStat.find search_stat_id
      html_result = fetch_html_result(search_stat.keyword)
      update_search_stat search_stat, ParserService.new(html_response: html_result).call
    end

    def fetch_html_result(keyword)
      Google::ClientService.new(keyword: keyword).call
    rescue StandardError => e
      Rails.logger.error("Error while fetching HTML result: #{e.message}")
      raise ClientServiceError, 'Error fetching HTML result'
    end

    def update_search_stat(search_stat, attributes)
      SearchStat.transaction do
        # rubocop:disable Rails/SkipsModelValidations
        search_stat.result_links.insert_all attributes[:result_links]
        # rubocop:enable Rails/SkipsModelValidations

        search_stat.update! attributes.except(:result_links)
      end
    end
  end
end
