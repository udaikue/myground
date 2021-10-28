set :output, 'log/crontab.log'
set :environment, :development
set :runner_command, "rails runner"

every :day, at: '1:08 pm' do
  runner "lib/batch/game_scrape.rb"
end
