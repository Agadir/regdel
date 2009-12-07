xml.select {
    @accounts.each do |account|
        xml.option( :value=>account.id, :text=>account.name )
    end
}
