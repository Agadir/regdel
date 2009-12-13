xml._R_ {
    xml.entries(:prev => @prev, :next => @next) {
    @myentries.each do |entry|
        newdate = Time.at(entry.entered_on) ? Time.at(entry.entered_on) : ""
        xml.entry( :memorandum=>entry.memorandum, :id=>entry.id, :date=>newdate, :amount => entry.credit_sum )

    end
    }
}
