xml.transactions( :ledger_label => @ledger_label, :ledger_type => @ledger_type  ) {
@mytransactions.each do |transx|
    xml.transaction(
      :transaction_id => transx.id,
      :account_name => transx.account.name,
      :date => transx.posted_on,
      :account_id => transx.account_id,
      :memorandum => transx.memorandum,
      :balance => transx.running_balance,
      :amount => transx.to_usd
      )
end
}
