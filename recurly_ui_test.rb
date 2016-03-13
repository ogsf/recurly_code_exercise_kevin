require 'watir-webdriver'
require 'rspec'

describe "Recurly UI" do

  before :all do
    @b = Watir::Browser.new :firefox
    @b.goto "http://recurly.com"
  end

  it "has zero accounts on Accounts page" do
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
    expect(@b.text).to include('All 0')
  end

  after :all do
    @b.close
  end

end