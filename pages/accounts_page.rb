class AccountsPage

  include PageObject

  # To visit the accounts page directly, use the following code in the spec file:
  # 'visit AccountsPage, :using_params => { :subdomain => api_auth["subdomain"] }'
  # This assumes the subdomain is taken from the data/data.yml

  @params = { :subdomain => 'kevint' }  #sets a default value for vanity URL
  page_url('https://<%=params[:subdomain]%>.recurly.com/accounts')

  #Element definitions
  #Note to self: The block below allows the use of css selectors with PageObject gem

  span(:web_total_accounts){ browser.element(:css => '.all_accounts span.Facet-option-count') }

  #Methods

end