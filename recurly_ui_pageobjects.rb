require 'watir-webdriver'
require 'rspec'
require 'page-object'

#Page classes
require_relative './login_page.rb'
require_relative './kevint_progress_page.rb'
require_relative './kevint_accounts_page.rb'

describe "Recurly UI" do

  before :all do
    @browser = Watir::Browser.new :firefox
    @browser.goto "http://recurly.com"
  end

  it "has zero accounts on Accounts page" do
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
    expect(kevint_accounts_page.all_accounts_count.to_i).to equal(0)
  end

  after :all do
    @browser.close
  end

end