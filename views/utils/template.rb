def gettemplate(myfile)
myvar = ''
    File.open(myfile, "r") { |f|
        myvar = f.read
    }
    return myvar
end
