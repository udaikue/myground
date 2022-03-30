# frozen_string_literal: true

class DB
  def initialize(urls)
    urls.each do |url|
      next if Scraping.where('url = ?', url).exists?

      scraping = Scraping.new
      scraping.url = url
      scraping.game_date = DateTime.now
      # scraping.game_date = '2022-3-31'
      scraping.save
    end
  end
end
