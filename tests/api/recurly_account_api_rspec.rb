#
# To run this here spec from project root;
# bundle exec rspec tests/api/recurly_account_api_rspec.rb --format documentation
#
# - Kevin Tinkler 3/13/16
#
require 'rubygems'
require 'recurly'
require 'rspec'
require 'date'

describe "Recurly Accounts API" do

  before :all do
    Recurly.subdomain         = 'kevint'
    Recurly.api_key           = '21ce91e03831452794dca50790304a52'
    Recurly.default_currency  = 'USD'
    @unique_account_code      = DateTime.now.strftime('%s')
  end

  it "creates a new account" do
    account = Recurly::Account.create(
      :account_code => @unique_account_code,
      :email        => 'kevin_1@boulder.net',
      :first_name   => 'Kevin_1',
      :last_name    => 'One',
      :company_name => 'ACME QA',
      :address      => {
        :address1   => '2666 W 119th Ave',
        :city       => 'Westminster',
        :state      => 'CO',
        :zip        => '80234',
        :country    => 'USA',
        :phone      => '719-289-5539'
     }
    )
    #confirm Account has been created successfully
    expect(account.response.inspect).to include('201 Created') 
  end

  it "confirms new account can be found" do
    account = Recurly::Account.find @unique_account_code
    expect(account.response.inspect).to include('200 OK')
  end  

end
