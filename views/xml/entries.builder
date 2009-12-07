xml._R_ {
    xml.entries(:prev => @prev, :next => @next) {
    @myentries.each do |entry|
        if entry.entered_on
            newdate = Time.at(entry.entered_on).utc.to_s
        else
            newdate = ""
        end
        mysum = entry.credits.sum(:amount)
        mysumm = "%.2f" % (mysum.to_r.to_d / 100)
        xml.entry( :memorandum=>entry.memorandum, :id=>entry.id, :date=>newdate, :amount => mysumm )

    end
    }
}
