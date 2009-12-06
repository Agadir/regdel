xml._R_ {
    xml.entries {
    @myentries.each do |entry|
        if entry.entered_on
            newdate = Time.at(entry.entered_on).utc.to_s
        else
            newdate = ""
        end

        xml.entry( :memorandum=>entry.memorandum, :id=>entry.id, :date=>newdate ) {

            @mycredits.each do |credit|
                if credit.entry_id == entry.id
                    xml.credit(:id=>credit.id,:amount=>credit.to_usd,:account=>credit.account_id)
                    @mycredits.delete(credit)
                end
            end

            @mydebits.each do |debit|
                if debit.entry_id == entry.id
                    xml.debit(:id=>debit.id,:amount=>debit.to_usd,:account=>debit.account_id)
                    @mydebits.delete(debit)
                end
            end
        }

    end
    }
}
