xml._R_ {
    xml.entries {
    @myentries.each do |entry|
        if entry.entered_on
            newdate = Time.at(entry.entered_on).utc.to_s
        else
            newdate = ""
        end

        xml.entry( :memorandum=>entry.memorandum, :id=>entry.id, :date=>newdate, :amount => entry.credits.sum(:amount) )

    end
    }
}
