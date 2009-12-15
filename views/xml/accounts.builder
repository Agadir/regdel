xml.accounts {
    @accounts.each do |account|
        xml.account(
          :id=>account.id,
          :name=>account.name,
          :number=>account.number,
          :balance=>account.cached_ledger_balance_usd,
          :type=> @my_account_types[account.type_id],
          :closed_on=>account.closed_on
        )
    end
}
