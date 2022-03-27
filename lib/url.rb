# frozen_string_literal: true

class URL
  def initialize(today_games)
    urls = []
    today_games.to_s.gsub(/\d+?月+\d+?日\(.\)|\d+?/, '').scan(/巨|ヤ|D|中|阪|広|日|楽|西|ロ|オ|ソ/).each_slice(2) do |g|
      card_url = DateTime.now.strftime('%y%m%d') + g.join('-')
      url = "https://baseball-freak.com/game/#{card_url}.html"
      urls << url.gsub(/巨|ヤ|D|中|阪|広|日|楽|西|ロ|オ|ソ/,
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
    puts urls
  end
end
