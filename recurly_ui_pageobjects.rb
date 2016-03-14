require 'watir-webdriver'
require 'rubygems'
require 'recurly'
require 'rspec'
require 'page-object'

#Page classes
require_relative './login_page.rb'
require_relative './kevint_progress_page.rb'
require_relative './kevint_accounts_page.rb'

describe "Recurly UI" do

  before :all do
    Recurly.subdomain = 'kevint'
    Recurly.api_key = '21ce91e03831452794dca50790304a52'
    @browser = Watir::Browser.new :firefox
    @browser.goto "http://recurly.com"
  end

  it "has correct number of accounts on Accounts page" do
    #Log in to Recurly App.
    login_page = LoginPage.new(@browser, true)  # 'true' argument invokes 'goto' method
    login_page.login_user('kevint@boulder.net', 'password1')

    #Navigate to Accounts page
    kevint_progress_page = KevintProgressPage.new(@browser)
    kevint_progress_page.accounts_link

    #confirm Accounts page has loaded
    expect(@browser.title).to include('Accounts — Recurly')
    expect(@browser.text).to include('Account Status')
    
    #confirm number of accounts
    kevint_accounts_page = KevintAccountsPage.new(@browser)
    total_accounts = 0
    Recurly::Account.find_each do |account|
      total_accounts += 1
    end
    expect(kevint_accounts_page.all_accounts_count.to_i).to equal(total_accounts)
  end

  after :all do
    @browser.close
  end

end