xml._R_ {
    xml.transactions(:prev => @prev, :next => @next) {
    @mytransactions.each do |transx|
        xml.transaction(
          :transaction_id => transx.id,
          :account_name => transx.account.name,
          :account_id => transx.account_id,
          :memorandum => transx.memorandum,
          :balance => transx.running_balance,
          :amount => transx.to_usd
          )
    end
    }
}
