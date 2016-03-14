class KevintAccountsPage

  include PageObject
  page_url('https://kevint.recurly.com/accounts')

  #Element definitions
  #Note to self: The block below allows the use of css selectors with PageObject gem
  span(:all_accounts_count){ browser.element(:css => '.all_accounts span.Facet-option-count') }

  #Methods

end