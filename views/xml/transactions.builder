xml._R_ {
    xml.transactions(:prev => @prev, :next => @next) {
    @mytransactions.each do |transaction|
        xml.transaction( :transaction_id => transaction.id)

    end
    }
}
