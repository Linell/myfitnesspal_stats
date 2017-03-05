require 'mechanize'

class Account
  #attr_reader :username, :password
  def initialize(username = nil, password = nil)
    @username = username
    @password = password

    @web_crawler = Mechanize.new do |web_crawler|
      web_crawler.follow_meta_refresh = true
    end
  end # ---- initialize

  def login
    # Go to homepage, click log in, and submit the form
    home_page              = @web_crawler.get('http://www.myfitnesspal.com/')
    login_form             = home_page.form_with(id: "fancy_login")
    login_form['username'] = @username
    login_form['password'] = @password
    current_page           = login_form.submit
    login_cookies          = @web_crawler.cookie_jar.save('cookies.yml', session: true)

    if current_page.links.detect {|l| l.to_s == 'Settings' }
      current_page
    else
      raise RuntimeError, "Invalid Login: #{current_page.search('p.flash').text}"
    end
  end
end
