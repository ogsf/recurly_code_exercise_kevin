#
# This file is my initial POC effort while figuring out the Recurly API.
# The Rspec test version is located at 'tests/api/recurly_account_api_rspec.rb'
#
# Run this here file from project root; 
# 'bundle exec ruby tests/api/recurly_account_api.rb'
#
# - Kevin Tinkler 3/14/16

require 'rubygems'
require 'recurly'
require 'yaml'

#Return nested hash of data from yaml file
@data = YAML.load_file("data/data.yml")
api_auth = @data["api_1"]

Recurly.subdomain         = api_auth["subdomain"]
Recurly.api_key           = api_auth["api_key"]
Recurly.default_currency  = api_auth["default_currency"]
@unique_account_code      = DateTime.now.strftime('%s')

begin

  #Clean up first part of data hash reference
  account_data = @data["api_account_1"]

  #Create an account.
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

  puts account.response.inspect #Looking at the HTTP Status Code
  puts                          #empty line to space output in terminal display

  #Check if the new account exists
  account = Recurly::Account.find @unique_account_code

  #if account does not exist, a NotFound Error will be thrown
  # account = Recurly::Account.find '54321'  #Uncomment to check the NotFound Error
  puts "Account: #{account.inspect}"
  rescue Recurly::Resource::NotFound => e
    puts e.message

end
