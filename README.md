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

The `scraper` instance is initialized with the current date. Everything below where we're
doing the `get_date` method can be called with no arguments and will default to the current
date.

### Accessing Nutritional Information 

To access nutritional information for a specified date, create a new `Day` instance and then call the `.nutrition_totals` on that day:

```ruby
scraper.get_date(Date.today)

# The date can also be a string parsable by Date.parse, ie "2017-02-14"
day = scraper.get_date("2017-02-14")
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

### Accessing Exercise Data

To access exercise information for a specified date, create a new `Day` instance and then 
call `.exercise_totals` on that day. The return format will look something like:

```ruby
{
           :minutes_today => 60.0,
      :goal_minutes_today => 45.0,
         :calories_burned => 278.0,
    :goal_calories_burned => 0.0
}
```

### Accessing Weight Data

To access weight information for a specified date, create a new `Day` instance and then 
call `.weight_data` on that day. The return will simply be a float representing the user's
weight on the given date or `nil` if there is no data for the date.

Note that this method only works for up to 90 days in the past. The reason is that the
API endpoint being used doesn't display the actual year or anything, so we want to limit it
to something reasonable so that we aren't accidentally getting the wrong data.

## Contributing

1. Fork it ( https://github.com/hgducharme/myfitnesspal_stats/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/hgducharme/myfitnesspal_stats/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

