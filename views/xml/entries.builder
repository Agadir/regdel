xml.entries { |b|
    @myentries.each do |entry|

        b.entry( :memorandum=>entry.memorandum, :id=>entry.id) { |amt|

            entry.credits.each do |credit|
                amt.credit(:id=>credit.id,:amount=>credit.to_usd)
            end

            entry.debits.each do |debit|
                amt.debit(:id=>debit.id,:amount=>debit.to_usd)
            end

        }
    end
}
