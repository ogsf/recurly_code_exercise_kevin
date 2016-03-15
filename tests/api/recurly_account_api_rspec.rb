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
require 'yaml'

describe "Recurly Accounts API" do

  before :all do
    #Return nested hash of data from yaml file
    @data = YAML.load_file("data/data.yml")
    api_auth = @data["api_1"]

    Recurly.subdomain         = api_auth["subdomain"]
    Recurly.api_key           = api_auth["api_key"]
    Recurly.default_currency  = api_auth["default_currency"]
    @unique_account_code      = DateTime.now.strftime('%s')
  end

  it "creates a new account" do
    #Clean up first part of data hash reference
    account_data = @data["api_account_1"]

    account = Recurly::Account.create(
    :account_code => @unique_account_code,
    :email        => account_data["email"],
    :first_name   => account_data["first_name"],
    :last_name    => account_data["last_name"],
    :company_name => account_data["company_name"],
    :address      => {
      :address1   => account_data["address1"],
      :city       => account_data["city"],
      :state      => account_data["state"],
      :zip        => account_data["zip"],
      :country    => account_data["country"],
      :phone      => account_data["phone"]
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
