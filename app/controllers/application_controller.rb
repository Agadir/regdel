class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :preload_modules

  def preload_modules
    unless Rails.env.production?
      load "#{Rails.root}/app/models/accounts/account_base.rb"
      load "#{Rails.root}/app/models/accounts/account.rb"
      [ "app/models/accounts", "app/models/transactions", "app/models/entries" ].each do |path|
        Dir["{Rails.root}/{path}/*.rb"].each do |file|
          load file
        end
      end
      Account
      Asset
      Liability
      Expense
      Revenue
      Other
      Equity
      BankAccount
      CreditCard
      Company
      Customer
      Vendor
      CurrentAsset
      CurrentLiability
      Receivable
      Payable
      Entry
      Check
      Transfer
      Invoice
      CreditCardCharge
    end
  end
end
