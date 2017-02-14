# MyfitnesspalStats

Myfitnesspal_Stats is a ruby module that allows you to programmatically access your daily nutritional information from [Myfitnesspal.com](http://www.myfitnesspal.com/). It gives you the ability to access your nutritional totals for a specified date, as well as the break down of each meal & food logged for that day.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'myfitnesspal_stats'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install myfitnesspal_stats

## Usage

### Getting Started 

Once installation of this gem is complete, initialize a new web scraper: 

```ruby
include 'myfitnesspal_stats'

# Insert your username and password for Myfitnesspal
scraper = Scraper.new('username', 'password')
```

### Accessing Nutritional Information 

To access nutritional information for a specified date, create a new `Day` instance and then call the `.nutrition_totals` on that day:

```ruby
# The year, month, and day should all be numbers. Although a string will still work
scraper.get_date(year, month, day)

# Numbers do not have to be padded with zeros, it can be 01 or just 1.
day = scraper.get_date(2017, 01, 15)
# ==> #<Day:<object id>

# Note: The nutrients that are returned depend on which nutrients you specified to track in your Myfitnesspal settings.
day.nutrition_totals
# ==> 
{
        :date => "2017-02-14",
    :calories => {
        :todays_total => 844.0,
          :daily_goal => 1528.0,
           :remaining => 684.0
    },
       :carbs => {
        :todays_total => 33.0,
          :daily_goal => 57.0,
           :remaining => 24.0
    },
         :fat => {
        :todays_total => 19.0,
          :daily_goal => 68.0,
           :remaining => 49.0
    },
     :protein => {
        :todays_total => 84.0,
          :daily_goal => 172.0,
           :remaining => 88.0
    },
      :sodium => {
        :todays_total => 286.0,
          :daily_goal => 2300.0,
           :remaining => 2014.0
    },
       :sugar => {
        :todays_total => 7.0,
          :daily_goal => 57.0,
           :remaining => 50.0
    }
}
```

## Contributing

1. Fork it ( https://github.com/hgducharme/myfitnesspal_stats/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/hgducharme/myfitnesspal_stats/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

