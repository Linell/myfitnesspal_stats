require 'mechanize'
require 'pry'

class Day
  def initialize(year, month, day)
    @date = Date.new(year, month, day)

    @login_page = 'http://www.myfitnesspal.com'

    @web_crawler = Mechanize.new do |web_crawler|
      web_crawler.cookie_jar.load('cookies.yml')
      web_crawler.follow_meta_refresh = true
    end
  end

  def nutrition_totals
    diary = @web_crawler.get("#{@login_page}/food/diary/#{@username}?date=
      #{@date}")
    totals_table = diary.search('tr.total')

    nutrients = diary.search('tfoot').search('td.alt')
      .map {|n| n.text.squeeze.split(' ').first }
      .map(&:downcase).map(&:to_sym)

    nutrient_totals        = Hash.new
    nutrient_totals[:date] = @date.to_s

    nutrients.each_with_index.map do |nutrient, index|
      nutrient_totals[nutrient] = {
        :todays_total => totals_table.search('td')[index + 1].text.sub(/\D/, '').to_f,
        :daily_goal   => totals_table.search('td')[index+9].text.sub(/\D/, '').to_f,
        :remaining    => totals_table.search('td')[index+17].text.sub(/\D/, '').to_f
      }
    end

    nutrient_totals
  end

=begin
  # WIP
  def weight
    reports = @web_crawler.get("#{@login_page}/reports/")
    weight_report = reports.search('//optgroup')[0].children[0]
    @web_crawler.click(weight_report)
  end
=end

end
