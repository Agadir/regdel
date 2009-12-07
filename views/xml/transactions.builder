xml._R_ {
    xml.transactions(:prev => @prev, :next => @next) {
    @mytransactions.each do |transx|
        xml.transaction(
          :transaction_id => transx.id,
          :account_id => transx.account_id,
          :memorandum => transx.memorandum,
          :amount => transx.to_usd
          )
    end
    }
}
