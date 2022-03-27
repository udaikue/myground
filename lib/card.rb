# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

class Card
  attr_reader :schedule

  def initialize
    # 試合がない日は?
    # 25:00までを今日とする

    schedule_url = 'https://baseball-freak.com/game/'

    schedule_html = URI.open(schedule_url).read
    schedule_doc = Nokogiri::HTML.parse(schedule_html)

    @schedule = []

    # 今シーズンの全日程を取得(配列)
    schedule_doc.css('.schedule tr').each do |date|
      @schedule << date.css('td').text
    end

    def today_games
      @schedule.grep(/#{DateTime.now.month}月#{DateTime.now.day}日*/)
    end
  end
end
