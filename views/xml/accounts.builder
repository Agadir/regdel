xml._R_ {
    xml.accounts {
        @accounts.each do |account|
            xml.account( :id=>account.id, :name=>account.name, :type=> @my_account_types[account.type_id], :closed_on=>account.closed_on )
        end
    }
}
