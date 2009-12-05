xml._R_ {
    xml.entries {
    @myentries.each do |entry|
        newdate = ""
        if entry.entered_on
            newdate = Time.at(entry.entered_on).utc.to_s
        end
        xml.entry( :memorandum=>entry.memorandum, :id=>entry.id, :date=>newdate ) {

            entry.credits.each do |credit|
                xml.credit(:id=>credit.id,:amount=>credit.to_usd,:account=>credit.account_id)
            end

            entry.debits.each do |debit|
                xml.debit(:id=>debit.id,:amount=>debit.to_usd,:account=>debit.account_id)
            end
        }

    end
    }
}
