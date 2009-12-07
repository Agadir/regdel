xml._R_ {
    xml.accounts {
        @accounts.each do |account|
            xml.account( :id=>account.id, :name=>account.name, :type=>account.type_id, :closed_on=>account.closed_on )
        end
    }
}
