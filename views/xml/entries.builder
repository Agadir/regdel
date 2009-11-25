builder = Builder::XmlMarkup.new(:indent=>2)
x = builder.entries { |b|
    @myentries.each do |entry|

        b.entry( :memorandum=>entry.memorandum, :id=>entry.id) { |amt|

            entry.credits.each do |credit|
                myamount = credit.amount.to_f / 100
                amt.credit(:id=>credit.id,:amount=>myamount)
            end

            entry.debits.each do |debit|
                myamount = debit.amount.to_f / 100
                amt.debit(:id=>debit.id,:amount=>myamount)
            end

        }
    end
}
return x
