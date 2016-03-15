#
# This test is in Rspec format and uses a page-object library to 
# centralize element definitions and page methods in one place.
#
# To run this here spec from the project root;
# 'bundle exec rspec tests/ui/recurly_ui_pageobjects.rb --format documentation'
#
# - Kevin Tinkler 3/14/16 
#
require 'watir-webdriver'
require 'rubygems'
require 'recurly'
require 'rspec'
require 'page-object'
require 'yaml'

#Page classes
require_relative '../../pages/login_page.rb'
require_relative '../../pages/progress_page.rb'
require_relative '../../pages/accounts_page.rb'

describe "Recurly UI" do

  before :all do
    #Return nested hash of data from yaml file
    @data = YAML.load_file("data/data.yml")
    api_auth = @data["api_1"]

    Recurly.subdomain = api_auth["subdomain"]
    Recurly.api_key = api_auth["api_key"]
    @browser = Watir::Browser.new :firefox
    @browser.goto @data["base_url"]
  end

  it "has correct number of accounts on Accounts page" do
    #Log in to Recurly App.
    login = @data["user_1"]
    login_page = LoginPage.new(@browser, true)  # 'true' argument invokes 'goto' method
    login_page.login_user(login["login_email"], login["login_password"])

    #Navigate to Accounts page
    progress_page = ProgressPage.new(@browser)
    progress_page.accounts_link

    #confirm Accounts page has loaded
    expect(@browser.title).to include('Accounts — Recurly')
    expect(@browser.text).to include('Account Status')
    
    #confirm number of accounts
    accounts_page = AccountsPage.new(@browser)
    api_total_accounts = 0
    Recurly::Account.find_each do |account|
      api_total_accounts += 1
    end

    expect(accounts_page.web_total_accounts.to_i).to eq(api_total_accounts)

  end

  after :all do
    @browser.close
  end

end