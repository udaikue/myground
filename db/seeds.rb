# frozen_string_literal: true

Team.create(
  [
    {
      league_id: 1,
      name: '巨人'
    },
    {
      league_id: 1,
      name: 'ヤクルト'
    },
    {
      league_id: 1,
      name: 'DeNA'
    },
    {
      league_id: 1,
      name: '中日'
    },
    {
      league_id: 1,
      name: '阪神'
    },
    {
      league_id: 1,
      name: '広島'
    },
    {
      league_id: 2,
      name: '日本ハム'
    },
    {
      league_id: 2,
      name: '楽天'
    },
    {
      league_id: 2,
      name: '西武'
    },
    {
      league_id: 2,
      name: 'ロッテ'
    },
    {
      league_id: 2,
      name: 'オリックス'
    },
    {
      league_id: 2,
      name: 'ソフトバンク'
    }
  ]
)

Game.create(
  [
    {
      date: Date.today,
      ballpark: '楽天生命パーク',
      team_home: '楽天',
      team_visitor: '西武',
      score_home: 1,
      score_visitor: 5,
      hits_home: 4,
      hits_visitor: 7,
      errors_home: 1,
      errors_visitor: 0,
      winning_pitcher: '今井(8勝7敗0S)',
      losing_pitcher: '瀧中(9勝5敗0S)',
      saving_pitcher: nil,
      homerun_home: '島内 20号(4回裏ソロ)',
      homerun_visitor: '山川 21号(8回表3ラン)'
    },
    {
      date: Date.today,
      ballpark: '札幌ドーム',
      team_home: '日本ハム',
      team_visitor: 'オリックス',
      score_home: 0,
      score_visitor: 3,
      hits_home: 3,
      hits_visitor: 4,
      errors_home: 0,
      errors_visitor: 0,
      winning_pitcher: '山﨑颯(2勝2敗0S)',
      losing_pitcher: '立野(4勝2敗0S)',
      saving_pitcher: '平野佳(1勝3敗27S)',
      homerun_home: nil,
      homerun_visitor: '杉本 32号(4回表3ラン)'
    },
    {
      date: Date.today.days_ago(2),
      ballpark: '楽天生命パーク',
      team_home: '楽天',
      team_visitor: '西武',
      score_home: 2,
      score_visitor: 5,
      hits_home: 4,
      hits_visitor: 7,
      errors_home: 1,
      errors_visitor: 0,
      winning_pitcher: '今井(8勝7敗0S)',
      losing_pitcher: '瀧中(9勝5敗0S)',
      saving_pitcher: nil,
      homerun_home: '島内 20号(4回裏ソロ)',
      homerun_visitor: '山川 21号(8回表3ラン)'
    },
    {
      date: Date.today.days_ago(2),
      ballpark: '札幌ドーム',
      team_home: '日本ハム',
      team_visitor: 'オリックス',
      score_home: 1,
      score_visitor: 3,
      hits_home: 3,
      hits_visitor: 4,
      errors_home: 0,
      errors_visitor: 0,
      winning_pitcher: '山﨑颯(2勝2敗0S)',
      losing_pitcher: '立野(4勝2敗0S)',
      saving_pitcher: '平野佳(1勝3敗27S)',
      homerun_home: nil,
      homerun_visitor: '杉本 32号(4回表3ラン)'
    }
  ]
)
