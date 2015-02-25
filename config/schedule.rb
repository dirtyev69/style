every 10.minutes do
  rake "get_news", :output => './log/cron_get_news.log'
end
