xml._R_ {
    xml.entries(:prev => @prev, :next => @next) {
    @myentries.each do |entry|
        xml.entry( :memorandum=>entry.memorandum, :id=>entry.id, :date=>entry.entered_on, :amount => entry.credit_sum )

    end
    }
}
