xml._R_ {
    xml.entries(:prev => @prev, :next => @next) {
    @myentries.each do |entry|
        if entry.entered_on
            #newdate = Time.at(entry.entered_on).utc.to_s
            newdate = Time.at(entry.entered_on)
        else
            newdate = ""
        end
        xml.entry( :memorandum=>entry.memorandum, :id=>entry.id, :date=>newdate, :amount => entry.credit_sum )

    end
    }
}
