# frozen_string_literal: true

require 'open-uri'

class GameCard
  def this_years_schedule
    schedule_url = 'https://baseball-freak.com/game/'

    schedule_html = URI.parse(schedule_url).open.read
    @schedule_doc = Nokogiri::HTML.parse(schedule_html)

    @schedule = []
    # 今シーズンの全日程を取得(配列)
    @schedule_doc.css('.schedule tr').each do |date|
      @schedule << date.css('td').text
    end
  end

  def today_cards
    today_element = @schedule.grep(/#{Date.current.month}月#{Date.current.day}日/)

    today_cards = []
    today_element.to_s.gsub(/\d+?月+\d+?日\(.\)|\d+?|京セラD大阪|楽天生命パーク|中止/, '').scan(/巨|ヤ|D|中|阪|広|日|楽|西|ロ|オ|ソ/).each_slice(2) do |g|
      path = Date.current.strftime('%y%m%d') + g.join('-')
      url = "https://baseball-freak.com/game/#{path}.html"
      today_cards << url.gsub(/巨|ヤ|D|中|阪|広|日|楽|西|ロ|オ|ソ/,
                              '巨' => 'g',
                              'ヤ' => 's',
                              'D' => 'yb',
                              '中' => 'd',
                              '阪' => 't',
                              '広' => 'c',
                              '日' => 'f',
                              '楽' => 'e',
                              '西' => 'l',
                              'ロ' => 'm',
                              'オ' => 'bs',
                              'ソ' => 'h')
    end
    today_cards
  end

  def save_scrapings(urls)
    urls.each do |url|
      next if Scraping.where('url = ?', url).exists?

      scraping = Scraping.new
      scraping.url = url
      scraping.game_date = Date.current
      scraping.save
    end
  end
end
