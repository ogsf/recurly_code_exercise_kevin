require 'watir-webdriver'
require 'rubygems'
require 'recurly'
require 'rspec'

describe "Recurly UI" do

  before :all do
    Recurly.subdomain = 'kevint'
    Recurly.api_key = '21ce91e03831452794dca50790304a52'
    @b = Watir::Browser.new :firefox
    @b.goto "http://recurly.com"
  end

  it "has correct number of accounts on Accounts page" do
    #Log in to Recurly App.
    @b.link(:text => "Log in").when_present.click
    @b.text_field(:id => 'user_email').set 'kevint@boulder.net'
    @b.text_field(:id => 'user_password').set 'password1'
    @b.button(:id => 'submit_button').click

    #Navigate to Accounts page
    @b.link(:text => "Accounts").when_present.click

    #confirm Accounts page has loaded
    expect(@b.title).to include('Accounts — Recurly')
    expect(@b.text).to include('Account Status')
    
    #confirm number of accounts
    total_accounts = 0
    Recurly::Account.find_each do |account|
      (total_accounts += 1).to_s
    end
    expect(@b.text).to include("Displaying all #{total_accounts} accounts")
  end

  after :all do
    @b.close
  end

end