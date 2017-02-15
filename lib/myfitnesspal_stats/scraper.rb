require_relative 'account'
require_relative 'day'
require 'mechanize'

class Scraper
  def initialize(username, password)
    @username = username
    @password = password
    @date     = Date.today

    @account    = Account.new(username, password)
    @login_page = @account.login

    @web_crawler = Mechanize.new do |web_crawler|
      web_crawler.cookie_jar.load('cookies.yml')
      web_crawler.follow_meta_refresh = true
    end
  end

  def get_date(date=@date)
    day = Day.new(date)
  end
end
