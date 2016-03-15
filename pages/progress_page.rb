class ProgressPage

  include PageObject
  # To visit the progress page directly, use the following code in the spec file:
  # 'visit ProgressPage, :using_params => { :subdomain => api_auth["subdomain"] }'
  # This assumes the subdomain is taken from the data/data.yml

  @params = { :subdomain => 'kevint' }  #sets a default value for vanity URL
  page_url('https://<%=params[:subdomain]%>.recurly.com/guides/progress')

  #Element definitions

  link(:accounts_link, text: 'Accounts')

  #Methods

end