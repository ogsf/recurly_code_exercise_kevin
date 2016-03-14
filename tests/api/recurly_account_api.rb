#
# "This is not yet my final form."  This file is just me figuring out the Recurly API.
# The Rspec version of this test is located at 'tests/api/recurly_account_api_rspec.rb'
#
# Run this here test from project root; 
# bundle exec ruby tests/api/recurly_account_api.rb
#
# - Kevin Tinkler 3/13/16
#
require 'rubygems'
require 'recurly'

Recurly.subdomain         = 'kevint'
Recurly.api_key           = '21ce91e03831452794dca50790304a52'
Recurly.default_currency  = 'USD'
@unique_account_code      = DateTime.now.strftime('%s')

begin

  #Create an account.
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

  puts account.response.inspect  #Looking at the HTTP Status Code
  puts #empty line to space output

  #Check if the new account exists
  #if account does not exist, a NotFound Error will be thrown
  account = Recurly::Account.find @unique_account_code
  # account = Recurly::Account.find '54321'  #To test the NotFound Error
  puts "Account: #{account.inspect}"
  rescue Recurly::Resource::NotFound => e
    puts e.message

end
