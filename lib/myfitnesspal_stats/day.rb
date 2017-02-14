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
    diary = @web_crawler.get("#{@login_page}/food/diary/#{@username}?date=#{@date}")
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

  def exercise_totals
    diary = @web_crawler.get("#{@login_page}/exercise/diary/#{@username}?date=#{@date}")

    # Get the raw data on minutes exercised. Note that MFP pretty much ignores strength
    # training, unless it's put in as cardio. We don't necessairly care about the weekly
    # goals, so we just focus on the first row of exercise data (excluding the spacer row).
    # NOTE: to modify this to care about weekly goals, we'd need to `.each` over the `tr`
    # search.
    # This is the format in which the data is put into raw_data.
    # ["DailyTotal", "Goal", "60", "45", "278", "0", " "]
    raw_data = diary.search('tfoot').search('tr')[1].text.squeeze.split("\n")
      .map    { |t| t.delete('/')       }
      .reject { |t| t.strip.empty?      }
      .map    { |t| t.delete(" \t\r\n") }

    {
      :minutes_today        => raw_data[2].to_f,
      :goal_minutes_today   => raw_data[3].to_f,
      :calories_burned      => raw_data[4].to_f,
      :goal_calories_burned => raw_data[5].to_f
    }
  end
end
