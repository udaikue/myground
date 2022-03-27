# frozen_string_literal: true

class DB
  def initialize(urls)
    urls.each do |url|
      scraping = Scraping.new
      scraping.url = url
      scraping.game_date = DateTime.now
      scraping.save
    end
  end
end
