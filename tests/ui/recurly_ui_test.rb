#
# This test is me figuring out Rspec and Watir for the first time.
# It works fine, but element definitions and functions should be abstracted out
# of the test. I did this with the 'tests/ui/recurly_ui_pageobjects.rb' spec,
# using an open source page-object library.
#
# To run this file from the project root:
# 'bundle exec ruby tests/ui/recurly_ui_test.rb'
#
# - Kevin Tinkler 3/14/16
#
require 'watir-webdriver'
require 'rubygems'
require 'recurly'
require 'rspec'
require 'yaml'

describe "Recurly UI" do

  before :all do
    #Return nested hash of data from yaml file
    @data = YAML.load_file("data/data.yml")
    api_auth = @data["api_1"]

    Recurly.subdomain = api_auth["subdomain"]
    Recurly.api_key = api_auth["api_key"]
    @b = Watir::Browser.new :firefox
    @b.goto @data["base_url"]
  end

  it "has correct number of accounts on Accounts page" do
    #Log in to Recurly App.
    login = @data["user_1"]
    @b.link(:text => "Log in").when_present.click
    @b.text_field(:id => 'user_email').set login["login_email"]
    @b.text_field(:id => 'user_password').set login["login_password"]
    @b.button(:id => 'submit_button').click

    #Navigate to Accounts page
    @b.link(:text => "Accounts").when_present.click

    #confirm Accounts page has loaded
    expect(@b.title).to include('Accounts — Recurly')
    expect(@b.text).to include('Account Status')
    
    #confirm number of accounts
    api_total_accounts = 0
    Recurly::Account.find_each do |account|
      (api_total_accounts += 1)
    end

    web_total_accounts = (@b.link(:class => 'all_accounts').span(:class => 'Facet-option-count').text).to_i
    expect(web_total_accounts).to eq(api_total_accounts)
  end

  after :all do
    @b.close
  end

end