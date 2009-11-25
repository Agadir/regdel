builder = Builder::XmlMarkup.new(:indent=>2)
x = builder.entries { |b|
    @myentries.each do |entry|
        b.entry(entry.id);
    end
}
return x
