xml._R_ {
    xml.entries {
    @myentries.each do |entry|

        xml.entry( :memorandum=>entry.memorandum, :id=>entry.id) {

            entry.credits.each do |credit|
                xml.credit(:id=>credit.id,:amount=>credit.to_usd)
            end

            entry.debits.each do |debit|
                xml.debit(:id=>debit.id,:amount=>debit.to_usd)
            end
        }

    end
    }
}
