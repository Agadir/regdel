builder = Builder::XmlMarkup.new(:indent=>2)
x = builder.entries { |b|
    @myentries.each do |entry|

        b.entry( :memorandum=>entry.memorandum, :id=>entry.id) { |amt|

            entry.credits.each do |credit|
                amt.credit(:id=>credit.id)
            end

            entry.debits.each do |debit|
                amt.debit(:id=>debit.id)
            end

        }
    end
}
return x
