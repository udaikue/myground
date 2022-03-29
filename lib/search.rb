# frozen_string_literal: true

require 'net/http'

class Search
  attr_reader :scrapings

  def initialize
    @scrapings = Scraping.where('game_date = ? and done = ?', DateTime.now, false)
    # @scrapings = Scraping.where('game_date = ? and done = ?', '2022-3-26', false)
  end

  def responsed_urls
    responsed_urls = []
    @scrapings.each do |scraping|
      response = Net::HTTP.get_response(URI.parse(scraping.url))
      responsed_urls << scraping.url if response.code == '200'
    end
    responsed_urls
  end
end
